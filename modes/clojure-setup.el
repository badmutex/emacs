(provide 'clojure-setup)

(setq inferior-lisp-program
      (let* ((java-path "java")
	     (java-options "")
	     (home (if (eq system-type 'darwin) "/Users/badi/"
				 (if (eq system-type 'gnu/linux) "/home/badi/"
				   (if (eq system-type 'windows-nt) "/Users/badi/"))))
	     (clojure-path (concat home "emacs/modes/clojure/"))
	     (class-path-delimiter ";")
	     (class-path (mapconcat (lambda (s) s)
				    (list (concat clojure-path "clojure.jar"))
				    class-path-delimiter)))
	(concat java-path
		" " java-options
		" -cp " class-path
		" clojure.lang.Repl")))

(setq load-path (cons "~/emacs/modes/clojure/clojure-mode" load-path))
(require 'clojure-mode)
(setq auto-mode-alist
      (cons '("\\.clj$" . clojure-mode)
	    auto-mode-alist))

(add-hook 'clojure-mode-hook
	  '(lambda ()
	     (define-key clojure-mode-map "\C-c\C-e" 'lisp-eval-last-sexp)))