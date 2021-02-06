#!/bin/bash
[ $(whoami) = root ] || \
    { sudo "$0" "$@"; exit $?; }`
