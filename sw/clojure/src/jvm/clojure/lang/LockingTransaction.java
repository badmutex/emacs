/**
 *   Copyright (c) Rich Hickey. All rights reserved.
 *   The use and distribution terms for this software are covered by the
 *   Common Public License 1.0 (http://opensource.org/licenses/cpl.php)
 *   which can be found in the file CPL.TXT at the root of this distribution.
 *   By using this software in any fashion, you are agreeing to be bound by
 * 	 the terms of this license.
 *   You must not remove this notice, or any other, from this software.
 **/

/* rich Jul 26, 2007 */

package clojure.lang;

import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.Callable;

@SuppressWarnings({"SynchronizeOnNonFinalField"})
public class LockingTransaction{

public static final int RETRY_LIMIT = 10000;
public static final int LOCK_WAIT_MSECS = 100;
public static final long BARGE_WAIT_NANOS = 10 * 1000000;
//public static int COMMUTE_RETRY_LIMIT = 10;

static final int RUNNING = 0;
static final int COMMITTING = 1;
static final int RETRY = 2;
static final int KILLED = 3;
static final int COMMITTED = 4;

final static ThreadLocal<LockingTransaction> transaction = new ThreadLocal<LockingTransaction>();


static class RetryEx extends Error{
}

static class AbortException extends Exception{
}

public static class Info{
	final AtomicInteger status;
	final long startPoint;


	public Info(int status, long startPoint){
		this.status = new AtomicInteger(status);
		this.startPoint = startPoint;
	}

	public boolean running(){
		int s = status.get();
		return s == RUNNING || s == COMMITTING;
	}
}

static class CFn{
	final IFn fn;
	final ISeq args;

	public CFn(IFn fn, ISeq args){
		this.fn = fn;
		this.args = args;
	}
}
//total order on transactions
//transactions will consume a point for init, for each retry, and on commit if writing
final private static AtomicInteger lastPoint = new AtomicInteger();

void getReadPoint(){
	readPoint = lastPoint.incrementAndGet();
}

long getCommitPoint(){
	return lastPoint.incrementAndGet();
}

void stop(int status){
	if(info != null)
		{
		synchronized(info)
			{
			info.status.set(status);
			info.notifyAll();
			}
		info = null;
		vals.clear();
		sets.clear();
		commutes.clear();
		//actions.clear();
		}
}


Info info;
long readPoint;
long startPoint;
long startTime;
final RetryEx retryex = new RetryEx();
final ArrayList<Agent.Action> actions = new ArrayList<Agent.Action>();
final HashMap<Ref, Object> vals = new HashMap<Ref, Object>();
final HashSet<Ref> sets = new HashSet<Ref>();
final TreeMap<Ref, ArrayList<CFn>> commutes = new TreeMap<Ref, ArrayList<CFn>>();


//returns the most recent val
Object lock(Ref ref){
	boolean unlocked = false;
	try
		{
		ref.lock.writeLock().lock();
		if(ref.tvals != null && ref.tvals.point > readPoint)
			throw retryex;
		Info refinfo = ref.tinfo;

		//write lock conflict
		if(refinfo != null && refinfo != info && refinfo.running())
			{
			if(!barge(refinfo))
				{
				ref.lock.writeLock().unlock();
				unlocked = true;
				//stop prior to blocking
				stop(RETRY);
				synchronized(refinfo)
					{
					if(refinfo.running())
						{
						try
							{
							refinfo.wait(LOCK_WAIT_MSECS);
							}
						catch(InterruptedException e)
							{
							}
						}
					}
				throw retryex;
				}
			}
		ref.tinfo = info;
		return ref.tvals == null ? null : ref.tvals.val;
		}
	finally
		{
		if(!unlocked)
			ref.lock.writeLock().unlock();
		}
}

void abort() throws AbortException{
	stop(KILLED);
	throw new AbortException();
}

private boolean bargeTimeElapsed(){
	return System.nanoTime() - startTime > BARGE_WAIT_NANOS;
}

private boolean barge(Info refinfo){
	boolean barged = false;
	//if this transaction is older
	//  try to abort the other
	if(bargeTimeElapsed() && startPoint < refinfo.startPoint)
		{
		synchronized(refinfo)
			{
			barged = refinfo.status.compareAndSet(RUNNING, KILLED);
			if(barged)
				refinfo.notifyAll();
			}
		}
	return barged;
}

static LockingTransaction getEx(){
	LockingTransaction t = transaction.get();
	if(t == null || t.info == null)
		throw new IllegalStateException("No transaction running");
	return t;
}

static LockingTransaction getRunning(){
	LockingTransaction t = transaction.get();
	if(t == null || t.info == null)
		return null;
	return t;
}

static public Object runInTransaction(Callable fn) throws Exception{
	LockingTransaction t = transaction.get();
	if(t == null)
		transaction.set(t = new LockingTransaction());

	if(t.info != null)
		return fn.call();

	return t.run(fn);
}

Object run(Callable fn) throws Exception{
	boolean done = false;
	Object ret = null;
	ArrayList<Ref> locked = new ArrayList<Ref>();

	for(int i = 0; !done && i < RETRY_LIMIT; i++)
		{
		try
			{
			getReadPoint();
			if(i == 0)
				{
				startPoint = readPoint;
				startTime = System.nanoTime();
				}
			info = new Info(RUNNING, startPoint);
			ret = fn.call();
			//make sure no one has killed us before this point, and can't from now on
			if(info.status.compareAndSet(RUNNING, COMMITTING))
				{
				for(Map.Entry<Ref, ArrayList<CFn>> e : commutes.entrySet())
					{
					Ref ref = e.getKey();
					ref.lock.writeLock().lock();
					locked.add(ref);
					Info refinfo = ref.tinfo;
					if(refinfo != null && refinfo != info && refinfo.running())
						{
						if(!barge(refinfo))
							throw retryex;
						}
					Object val = ref.tvals == null ? null : ref.tvals.val;
					if(!sets.contains(ref))
						vals.put(ref, val);
					for(CFn f : e.getValue())
						{
						vals.put(ref, f.fn.applyTo(RT.cons(vals.get(ref), f.args)));
						}
					}
				for(Ref ref : sets)
					{
					if(!commutes.containsKey(ref))
						{
						ref.lock.writeLock().lock();
						locked.add(ref);
						}
					}

				//validate
				for(Map.Entry<Ref, Object> e : vals.entrySet())
					{
					Ref ref = e.getKey();
					ref.validate(ref.getValidator(), e.getValue());
					}

				//at this point, all values calced, all refs to be written locked
				//no more client code to be called
				long msecs = System.currentTimeMillis();
				long commitPoint = getCommitPoint();
				for(Map.Entry<Ref, Object> e : vals.entrySet())
					{
					Ref ref = e.getKey();
					if(ref.tvals == null)
						{
						ref.tvals = new Ref.TVal(e.getValue(), commitPoint, msecs);
						}
					else if(ref.faults.get() > 0)
						{
						ref.tvals = new Ref.TVal(e.getValue(), commitPoint, msecs, ref.tvals);
						ref.faults.set(0);
						}
					else
						{
						ref.tvals = ref.tvals.next;
						ref.tvals.val = e.getValue();
						ref.tvals.point = commitPoint;
						ref.tvals.msecs = msecs;
						}
					}

				done = true;
				info.status.set(COMMITTED);
				}
			}
		catch(RetryEx retry)
			{
			//eat this so we retry rather than fall out
			}
		finally
			{
			for(int k = locked.size() - 1; k >= 0; --k)
				{
				locked.get(k).lock.writeLock().unlock();
				}
			locked.clear();
			stop(done ? COMMITTED : RETRY);
			if(done) //re-dispatch out of transaction
				{
				for(Agent.Action action : actions)
					{
					Agent.dispatchAction(action);
					}
				}
			actions.clear();
			}
		}
	if(!done)
		throw new Exception("Transaction failed after reaching retry limit");
	return ret;
}

public void enqueue(Agent.Action action){
	actions.add(action);
}

Object doGet(Ref ref){
	if(!info.running())
		throw retryex;
	if(vals.containsKey(ref))
		return vals.get(ref);
	try
		{
		ref.lock.readLock().lock();
		if(ref.tvals == null)
			throw new IllegalStateException(ref.toString() + " is unbound.");
		Ref.TVal ver = ref.tvals;
		do
			{
			if(ver.point <= readPoint)
				return ver.val;
			} while((ver = ver.prior) != ref.tvals);
		}
	finally
		{
		ref.lock.readLock().unlock();
		}
	//no version of val precedes the read point
	ref.faults.incrementAndGet();
	throw retryex;

}

Object doSet(Ref ref, Object val){
	if(!info.running())
		throw retryex;
	if(commutes.containsKey(ref))
		throw new IllegalStateException("Can't set after commute");
	if(!sets.contains(ref))
		{
		sets.add(ref);
		lock(ref);
		}
	vals.put(ref, val);
	return val;
}

void doTouch(Ref ref){
	if(!info.running())
		throw retryex;
	lock(ref);
}

Object doCommute(Ref ref, IFn fn, ISeq args) throws Exception{
	if(!info.running())
		throw retryex;
	if(!vals.containsKey(ref))
		{
		Object val = null;
		try
			{
			ref.lock.readLock().lock();
			val = ref.tvals == null ? null : ref.tvals.val;
			}
		finally
			{
			ref.lock.readLock().unlock();
			}
		vals.put(ref, val);
		}
	ArrayList<CFn> fns = commutes.get(ref);
	if(fns == null)
		commutes.put(ref, fns = new ArrayList<CFn>());
	fns.add(new CFn(fn, args));
	Object ret = fn.applyTo(RT.cons(vals.get(ref), args));
	vals.put(ref, ret);
	return ret;
}

/*
//for test
static CyclicBarrier barrier;
static ArrayList<Ref> items;

public static void main(String[] args){
	try
		{
		if(args.length != 4)
			System.err.println("Usage: LockingTransaction nthreads nitems niters ninstances");
		int nthreads = Integer.parseInt(args[0]);
		int nitems = Integer.parseInt(args[1]);
		int niters = Integer.parseInt(args[2]);
		int ninstances = Integer.parseInt(args[3]);

		if(items == null)
			{
			ArrayList<Ref> temp = new ArrayList(nitems);
			for(int i = 0; i < nitems; i++)
				temp.add(new Ref(0));
			items = temp;
			}

		class Incr extends AFn{
			public Object invoke(Object arg1) throws Exception{
				Integer i = (Integer) arg1;
				return i + 1;
			}

			public Obj withMeta(IPersistentMap meta){
				throw new UnsupportedOperationException();

			}
		}

		class Commuter extends AFn implements Callable{
			int niters;
			List<Ref> items;
			Incr incr;


			public Commuter(int niters, List<Ref> items){
				this.niters = niters;
				this.items = items;
				this.incr = new Incr();
			}

			public Object call() throws Exception{
				long nanos = 0;
				for(int i = 0; i < niters; i++)
					{
					long start = System.nanoTime();
					LockingTransaction.runInTransaction(this);
					nanos += System.nanoTime() - start;
					}
				return nanos;
			}

			public Object invoke() throws Exception{
				for(Ref tref : items)
					{
					LockingTransaction.getEx().doCommute(tref, incr);
					}
				return null;
			}

			public Obj withMeta(IPersistentMap meta){
				throw new UnsupportedOperationException();

			}
		}

		class Incrementer extends AFn implements Callable{
			int niters;
			List<Ref> items;


			public Incrementer(int niters, List<Ref> items){
				this.niters = niters;
				this.items = items;
			}

			public Object call() throws Exception{
				long nanos = 0;
				for(int i = 0; i < niters; i++)
					{
					long start = System.nanoTime();
					LockingTransaction.runInTransaction(this);
					nanos += System.nanoTime() - start;
					}
				return nanos;
			}

			public Object invoke() throws Exception{
				for(Ref tref : items)
					{
					//Transaction.get().doTouch(tref);
//					LockingTransaction t = LockingTransaction.getEx();
//					int val = (Integer) t.doGet(tref);
//					t.doSet(tref, val + 1);
					int val = (Integer) tref.get();
					tref.set(val + 1);
					}
				return null;
			}

			public Obj withMeta(IPersistentMap meta){
				throw new UnsupportedOperationException();

			}
		}

		ArrayList<Callable<Long>> tasks = new ArrayList(nthreads);
		for(int i = 0; i < nthreads; i++)
			{
			ArrayList<Ref> si;
			synchronized(items)
				{
				si = (ArrayList<Ref>) items.clone();
				}
			Collections.shuffle(si);
			tasks.add(new Incrementer(niters, si));
			//tasks.add(new Commuter(niters, si));
			}
		ExecutorService e = Executors.newFixedThreadPool(nthreads);

		if(barrier == null)
			barrier = new CyclicBarrier(ninstances);
		System.out.println("waiting for other instances...");
		barrier.await();
		System.out.println("starting");
		long start = System.nanoTime();
		List<Future<Long>> results = e.invokeAll(tasks);
		long estimatedTime = System.nanoTime() - start;
		System.out.printf("nthreads: %d, nitems: %d, niters: %d, time: %d%n", nthreads, nitems, niters,
		                  estimatedTime / 1000000);
		e.shutdown();
		for(Future<Long> result : results)
			{
			System.out.printf("%d, ", result.get() / 1000000);
			}
		System.out.println();
		System.out.println("waiting for other instances...");
		barrier.await();
		synchronized(items)
			{
			for(Ref item : items)
				{
				System.out.printf("%d, ", (Integer) item.currentVal());
				}
			}
		System.out.println("\ndone");
		System.out.flush();
		}
	catch(Exception ex)
		{
		ex.printStackTrace();
		}
}
*/
}