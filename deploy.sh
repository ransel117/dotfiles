#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"

echo $SCRIPT_DIR

DEST_DIR="$HOME"
# testing
#DEST_DIR="$SCRIPT_DIR/test"

echo $DEST_DIR

mkdir -p "$DEST_DIR/.config"

EXISTS="file/folder already exists"

[[ -f "$DEST_DIR/.bashrc"         ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/bashrc"       "$DEST_DIR/.bashrc"
[[ -f "$DEST_DIR/.bash_profile"   ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/bash_profile" "$DEST_DIR/.bash_profile"
[[ -f "$DEST_DIR/.bash_aliases"   ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/bash_aliases" "$DEST_DIR/.bash_aliases"
[[ -f "$DEST_DIR/.Xresources"     ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/Xresources"   "$DEST_DIR/.Xresources"
[[ -f "$DEST_DIR/.emacs"          ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/emacs"        "$DEST_DIR/.emacs"
[[ -f "$DEST_DIR/.gitconfig"      ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/gitconfig"    "$DEST_DIR/.gitconfig"
[[ -f "$DEST_DIR/.gtkrc-2.0"      ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/gtkrc-2.0"    "$DEST_DIR/.gtkrc-2.0"
[[ -d "$DEST_DIR/.config/i3"      ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/i3"           "$DEST_DIR/.config/i3"
[[ -d "$DEST_DIR/.config/gtk-3.0" ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/gtk-3.0"      "$DEST_DIR/.config/gtk-3.0"
[[ -f "$DEST_DIR/.xinitrc"        ]] && echo "$EXISTS" || ln -s "$SCRIPT_DIR/xinitrc"      "$DEST_DIR/.xinitrc"

ls -lFa "$DEST_DIR"
