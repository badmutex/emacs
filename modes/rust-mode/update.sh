#!/usr/bin/env bash

mydir=$(dirname $0)
cd $mydir


wget \
    --no-check-certificate \
    'https://raw2.github.com/rust-lang/rust/master/src/etc/emacs/rust-mode.el' \
    -O rust-mode.el
