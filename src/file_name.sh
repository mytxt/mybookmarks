#!/bin/bash

FILE="example.tar.gz"
echo "${FILE%%.*}"
#example

echo "${FILE%.*}"
#example.tar

echo "${FILE#*.}"
#tar.gz

echo "${FILE##*.}"
#gz
