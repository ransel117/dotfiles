#!/bin/sh

# Stolen from herrhotzenplotz

# AUTOMATIC DEPLOY SCRIPT
# to deploy to the $HOME folder place the files/folders in the homedir/ folder
# to deploy to the $HOME/.config folder place the files/folders in the config/ folder
# to deploy to the $HOME/.local/bin folder place the files in the localbin/ folder

INFOTAG="\033[01;36m[INFO]\033[0m"
LINKTAG="\033[01;32m[LINK]\033[0m"

CONF_FOLDER=".config"

echo "$INFOTAG Checking $HOME links..."
HOME_FILES=$(find homedir/ -maxdepth 1 -type f -o -type d ! -path homedir/)
for SRCPATH in $HOME_FILES; do
    TARGETPATH="$HOME/$(basename $SRCPATH)"
    [ -L $TARGETPATH ] || (echo -n "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

if [ $XDG_CONF_PATH ]; then
    CONF_TARGET="$XDG_CONF_PATH"
else
    CONF_TARGET="$HOME/.config/"
fi

echo "$INFOTAG Checking $CONF_TARGET links..."
CONF_FILES=$(find config/ -maxdepth 1 -type f -o -type d ! -path config/)
for SRCPATH in $CONF_FILES; do
    TARGETPATH="$CONF_TARGET/$(basename $SRCPATH)"
    [ -L $TARGETPATH ] || (echo -n "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

if [ -d "$HOME/.local/bin" ]; then
    echo "$INFOTAG $HOME/.local/bin exists"
else
    echo "$INFOTAG Creating $HOME/.local/bin/..."
    mkdir -p $HOME/.local/bin
fi

echo "$INFOTAG Checking $HOME/.local/bin links"
LOCALBIN_FILES=$(find localbin/ -maxdepth 1 -type f -o -type d ! -path localbin/)
for SRCPATH in $LOCALBIN_FILES; do
    TARGETPATH="$HOME/.local/bin/$(basename $SRCPATH)"
    [ -L $TARGETPATH ] || (echo -n "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

