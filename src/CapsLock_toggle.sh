#!/bin/bash

# state=$(cat /sys/class/leds/input3::capslock/brightness)
# another way is to use state=$(xset q | grep LED | awk '{ print $10}' | bc)
# 0 if capslock is OFF and 1001 if ON

# echo "\$state=$state"

# if [[ "$state" -eq 1 ]]; then
#     # xset -led named 'Caps Lock'
#     echo 0 | sudo tee '/sys/class/leds/input3::capslock/brightness'
# else
#     # xset led named 'Caps Lock'
#     echo 1 | sudo tee '/sys/class/leds/input3::capslock/brightness'
# fi
#
# exit 0

# layout control
# logger \$PPID=$PPID \$\$=$$
# a=`ps -q $PPID -o comm=`
# b=`ps -q $$ -o comm=`
# logger "$a $b"

log() {
    logger "$(printf "%s" "$1")"
}

if [[ $(ps -q $PPID -o comm=) = "xfsettingsd" ]]; then cmd=log; else cmd="echo -en"; fi
layout=$(xkb-switch | awk -F"(" '{ print $1 }')
c="\$layout=$layout ("
if [ "$layout" = "ru" ]; then
    xset led named 'Caps Lock'
    c+="layout==ru, turn ON CapsLock)\n"
else
    xset -led named 'Caps Lock'
    c+="layout!=ru, turn OFF CapsLock)\n"
fi
$cmd "$c"
$cmd "$(cat /sys/class/leds/input3::capslock/brightness)\n"
