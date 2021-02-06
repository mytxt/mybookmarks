#!/bin/sh

#You need to:
#
#    Update the timestamp on the top-level icon directory
#    Run gtk-update-icon-cache
#

\sudo touch /usr/share/icons/hicolor && \
touch ~/.local/share/icons/hicolor && \
sudo gtk-update-icon-cache
