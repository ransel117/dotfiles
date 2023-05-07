# used for login shells

# include .bashrc if it exists
[[ -f "~/.bashrc" ]]    && . "~/.bashrc"

# set PATH so it includes user's private bin if it exists
[[ -d "~/bin" ]]        && PATH="~/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[[ -d "~/.local/bin" ]] && PATH="~/.local/bin:$PATH"

pgrep 'startx' || exec startx
