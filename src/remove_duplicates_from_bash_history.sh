#!/bin/bash

pushd ~

a=${1:-.bash_history}
b="$a.new"
#echo $a $b
awk '!x[$0]++' $a > $b

popd
