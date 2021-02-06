#!/bin/bash -i
# Script to check the alias output

shopt -s expand_aliases
alias ls1='ls -lrt'
echo
echo internal alias
ls1

read -p "press any key to continue ..."
# что-бы этот алиас сработал надо запускать либо как bash -i script.sh (как он сейчас должен запускаться)
# или через source script.sh
echo alias from .bashrc
la
read -p "press any key to continue ..."
