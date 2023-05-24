#!/bin/bash

# used for login shells

# include .bashrc if it exists
[[ -f "$HOME/.bashrc" ]]    && . "$HOME/.bashrc"

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/bin" ]]        && PATH="$PATH:$HOME/bin"

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/.local/bin" ]] && PATH="$PATH:$HOME/.local/bin"

pgrep 'startx' || exec startx
