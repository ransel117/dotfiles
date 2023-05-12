#!/bin/sh

setxkbmap -layout se -option ctrl:nocaps

[ -f $HOME/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources

urxvtd -q -o -f &
[ -e /tmp/emacs/server ] || emacs -- daemon &

exec dbus-launch --exit-with-session i3
