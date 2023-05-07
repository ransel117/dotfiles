setxkbmap -layout se

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

exec dbus-launch --exit-with-session i3
