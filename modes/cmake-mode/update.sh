#!/usr/bin/env bash

mydir=$(dirname $0)
cd $mydir

wget \
    'http://cmake.org/gitweb?p=cmake.git;a=blob_plain;hb=master;f=Auxiliary/cmake-mode.el' \
    -O cmake-mode.el

wget \
    --no-check-certificate \
    'https://raw2.github.com/Lindydancer/cmake-font-lock/master/andersl-cmake-font-lock.el' \
    -O andersl-cmake-font-lock.el
