#!/bin/bash

. ./bash_color-master/color

text=${1:-'Hello Wo00000o0000000o000orld! '}; N=${#text}

function bye {
    stty echo
    printf "${CON}${DEF}"
    clear
    ls --color=auto
    exit
}

function get_dimensions {
    size=($(stty  size))
    endx=${size[1]}
    endy=${size[0]}
}

get_dimensions
trap bye INT
stty -echo
printf "${COF}"
IFSOLD=$IFS
IFS=$'\n'

# добавился фиглет
figlet_text=( $(figlet -w$[$N*10] "${text}") )
IFS=$IFSOLD
NF=${#figlet_text[1]}
NFL=${#figlet_text[*]}
X=$[$endx+1]
Y=$[$endy/2-$NFL/2]
L=0; clear

while true; do sleep 0.05; get_dimensions

    if [ $X -gt 1 ]; then
        # цикл по элементам фиглетового текста
        for ((i=0; i<$NFL; i++)); do
            XY $X $[$Y+$i] "${figlet_text[$i]:0:$L}"
        done
    else
        for ((i=0; i<$NFL; i++)); do
            XY 1  $[$Y+$i] "${figlet_text[$i]:$[1-$X]:$L}"
        done
    fi

    [ $X -lt  -$NF ] && { X=$endx; L=0; } || ((X--))
    [ $L -lt $endx ] && ((L++))

done
