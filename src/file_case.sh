#!/bin/bash

for a_file in *;do
	mv -v "$a_file" `echo "$a_file" | tr [:upper:] [:lower:]`
done
