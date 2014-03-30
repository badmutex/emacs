#!/usr/bin/env bash

# script to byte-compile all the elisp files provided by the modes

set -e

bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
txtrst='\e[0m'    # Text Reset


################################################################################ utils

emacs-byte-compile-files() {
    local libs="$1"
    shift
    local paths=$@
    L="$(for l in $libs; do echo -L $l; done)"
    
    emacs $L -batch -f batch-byte-compile $paths
}

################################################################################ compile

byte-compile-auto-complete.git() {
    git submodule update --init
    make byte-compile
}

byte-compile-deferred.git() {
    emacs-byte-compile-files "." {deferred,concurrent}.el
}

byte-compile-epc.git() {
    emacs-byte-compile-files ". ../deferred.git ../ctable.git" epc.el
}

byte-compile-f.git() {
    emacs-byte-compile-files ". ../s.git ../dash.git/" f.el
}

byte-compile-flycheck.git() {
    emacs-byte-compile-files ". ../s.git ../f.git ../dash.git" flycheck.el
}

byte-compile-jedi.git() {
    emacs-byte-compile-files ".  ../python-environment.git ../popup.git ../auto-complete.git ../ctable.git ../deferred.git ../epc.git" jedi.el
}

byte-compile-python-environment.git() {
    emacs-byte-compile-files ". ../deferred.git" python-environment.el
}


################################################################################ main


packages=*

for name in $packages; do
    test -d $name || continue
    test $name == ide-python && continue
    printf "$bldred[ $name ]$txtrst\n" 1>&2
    pushd $name >/dev/null 2>&1
    compile=byte-compile-$name
    if type -t $compile >/dev/null; then
	$compile
    else
	emacs-byte-compile-files "." *.el
    fi 2>&1
    popd  >/dev/null 2>&1
    printf "$bldgrn[ OK ]$txtrst\n" 1>&2
done
