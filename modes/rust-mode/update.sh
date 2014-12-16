#!/usr/bin/env bash

mydir=$(dirname $0)
cd $mydir


curl \
    'https://raw.githubusercontent.com/rust-lang/rust/master/src/etc/emacs/rust-mode.el' \
    -o rust-mode.el
