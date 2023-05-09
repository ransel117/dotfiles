#!/bin/sh

setxkbmap -layout se

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

[[ -e /tmp/emacs/server ]] || emacs -- daemon &

exec dbus-launch --exit-with-session i3
