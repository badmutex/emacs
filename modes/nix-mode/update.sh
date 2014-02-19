#!/usr/bin/env bash

mydir=$(dirname $0)
cd $mydir
wget \
    --no-check-certificate \
    https://raw2.github.com/NixOS/nix/master/misc/emacs/nix-mode.el
