#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"

echo $SCRIPT_DIR

DEST_DIR="$HOME"
# testing
#DEST_DIR="$SCRIPT_DIR/test"

echo $DEST_DIR

mkdir -p "$DEST_DIR/.config"

ln -s "$SCRIPT_DIR/bashrc"       "$DEST_DIR/.bashrc"
ln -s "$SCRIPT_DIR/bash_profile" "$DEST_DIR/.bash_profile"
ln -s "$SCRIPT_DIR/bash_aliases" "$DEST_DIR/.bash_aliases"
ln -s "$SCRIPT_DIR/Xresources"   "$DEST_DIR/.Xresources"
ln -s "$SCRIPT_DIR/emacs"        "$DEST_DIR/.emacs"
ln -s "$SCRIPT_DIR/gitconfig"    "$DEST_DIR/.gitconfig"
ln -s "$SCRIPT_DIR/gtkrc-2.0"    "$DEST_DIR/.gtkrc-2.0"
ln -s "$SCRIPT_DIR/i3"           "$DEST_DIR/.config/i3"
ln -s "$SCRIPT_DIR/gtk-3.0"      "$DEST_DIR/.config/gtk-3.0"
ln -s "$SCRIPT_DIR/xinitrc"       "$DEST_DIR/.xinitrc"
