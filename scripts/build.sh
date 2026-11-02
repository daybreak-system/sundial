#!/bin/sh
set -evu

mkdir build

crystal build --progress --verbose src/sundial.cr -o build/sundial 

ln -s ./sundial build/cat
ln -s ./sundial build/echo
ln -s ./sundial build/wc
