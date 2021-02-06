#!/bin/bash -i

# . ./config.postinstall

insty xsel
insty synaptic fim fbi gparted iotop

xsel -x # backup primary to secondary selection
xsel -cp # clear primary selection S-Ins

a2pc "synaptic" # add synaptic to sudoers, via clipboard, in order to run w/o asking of password
# a2pc "service" # service тоже
a2pc "apt update" # apt update
a2pc "gparted" # gparted
a2pc "fbi" # image and movie (some) viewer, работает и в консоли
a2pc "fim" # только images
a2pc "iotop"
a2pc "radeotop"

echo "Primary clipboard:"
xsel -p; echo # show primary content
xsel -x # swap
echo "Primary clipboard (old):"
xsel -p; echo

#exit

# TODO
# надо заменить на консольный промпт
#
# 1'st attempt:

if [[ $f -ge 1 ]]; then # если хоть одна программа (что мы хотим запускать из под root без пароля) отсутствует, то предлагаем вставить её в sudoers:
    xsel -p
    whiptail --title "Sudoers" --msgbox "В клипбоарде программы, кототорые Вы можете добавить в sudoers. При заоуске из под руута пароль запрашиваться не будет." 0 0
    sudo visudo
else
    whiptail --title "Sudoers" --msgbox "OK. Порядок. Пилим дальше." 0 0
fi

xsel -x # restore old selection
#test $DEBUG && exit 0
#echo DEBUG is not defined;echo; exit

sudo apt remove -y thunderbird


insty debian-goodies

#build-essential
#console-setup
insty xfonts-terminus orage xfce4-clipman-plugin encfs openssh-server

insty cmake autopoint
#libncurses-dev
#libx11-dev
#libxdamage-dev
#libxcb-shape0-dev

insty libimlib2-dev libncurses5-dev libx11-dev libxdamage-dev libxft-dev libxinerama-dev libxml2-dev libcurl4-nss-dev liblua5.3-dev curl jq net-tools libglib2.0-dev



# build conky from src
#if [ -d ~/Documents/src/conky ]; then
#   if (whiptail --title "Вопросец возник" --yesno "Будем компилировать и ставить conky ?" 0 0); then
#       cd ~/Documents/src/conky
#       git pull
#       rm -r build
#       mkdir build
#       cd build
#       cmake ..
#       make
#       sudo make install
#   fi
#fi

insty xdotool sysvbanner xfdashboard gnome-gmail markdown

insty python-pip python3-pip python-tk python3-tk

#insty eog eog-plugin-fit-to-width eog-plugin-maximize-windows

insty htop iotop powertop radeontop

#sudo add-apt-repository ppa:daniruiz/flat-remix
#sudo apt-get update
#insty flat-remix
#flat-remix-gtk

#insty adwaita-icon-theme-full adwaita-qt

insty atool arc arj lzip lzop nomarch rar rpm unace unalz unrar
insty libslang2-dev

insty pandoc
pip3 install --user sphinx-markdown
pip3 install --user sphinx_rtd_theme
pip3 install --user sphinxprettysearchresults
pip3 install --user colorama

# build mc
#if [ -d ~/Documents/src/mc ]; then
#   if (whiptail --title "Вопросец возник" --yesno "Будем компилировать и ставить Midnight Commander ?" 0 0); then
#       cd ~/Documents/src/mc
#       git pull
#       ./configure && \
#       make && \
#       sudo make all
#   fi
#fi

insty sqlite3 odt2txt

# mlabel (for unetbootin)
insty mtools

insty wine-development winetricks wine-binfmt
insty mono-complete
insty gtk-sharp2
winetricks -q --force dotnet45

insty ispell irussian mbrola mbrola-ee1 mbrola-en1
insty translate-shell
insty console-cyrillic
insty enca

#insty murrine-themes shiki-colors

#sudo add-apt-repository ppa:videolan/master-daily
#sudo apt-get update
#sudo apt-get instyall vlc

insty fonts-open-sans
insty libgtk-3-dev

insty xboard

insty xscreensaver-*

# libgnomeui-0

insty mplayer libdirectfb-extra mpv

