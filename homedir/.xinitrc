#!/bin/sh

setxkbmap -layout se -option ctrl:nocaps

xrdb -merge -I$HOME ~/.Xresources

[[ -e /tmp/emacs/server ]] || emacs -- daemon &

exec dbus-launch --exit-with-session i3
