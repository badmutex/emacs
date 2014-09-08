#!/usr/bin/env bash

mydir=$(dirname $0)
cd $mydir


wget \
    --no-check-certificate \
    'https://raw2.github.com/dominikh/go-mode.el/master/go-mode.el' \
    -O go-mode.el
