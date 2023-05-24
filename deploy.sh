#!/bin/sh

# Stolen from herrhotzenplotz

# AUTOMATIC DEPLOY SCRIPT
# to deploy to the $HOME folder place the files/folders in the homedir/ folder
# to deploy to the $HOME/.config folder place the files/folders in the config/ folder
# to deploy to the $HOME/.local/bin folder place the files in the localbin/ folder

INFOTAG="\033[36m[INFO]\033[0m"
LINKTAG="\033[32m[LINK]\033[0m"

DEFAULT_SRC="all"
if [ "$1" = "debian" ]; then
    OS_SRC="debarch"
else
    OS_SRC=
fi

if [ $XDG_CONF_PATH ]; then
    CONF_TARGET="$XDG_CONF_PATH"
else
    CONF_TARGET="$HOME/.config"
fi
LOCALBIN_TARGET="$HOME/.local/bin"

if [ -d "$CONF_TARGET" ]; then
    echo -e "$INFOTAG $CONF_TARGET exists"
else
    echo -e "$INFOTAG Creating $CONF_TARGET"
    mkdir -p "$CONF_TARGET"
fi

if [ -d "$LOCALBIN_TARGET" ]; then
    echo -e "$INFOTAG $LOCALBIN_TARGET exists"
else
    echo -e "$INFOTAG Creating $LOCALBIN_TARGET"
    mkdir -p "$LOCALBIN_TARGET"
fi

echo -e "$INFOTAG Checking $HOME links..."
HOME_FILES=`find $DEFAULT_SRC/homedir/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/homedir/`
for SRCPATH in $HOME_FILES; do
    TARGETPATH="$HOME/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || (echo -e "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

echo -e "$INFOTAG Checking $CONF_TARGET links..."
CONF_FILES=`find $DEFAULT_SRC/config/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/config/`
for SRCPATH in $CONF_FILES; do
    TARGETPATH="$CONF_TARGET/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || (echo -e "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

echo -e "$INFOTAG Checking $LOCALBIN_TARGET links"
LOCALBIN_FILES=`find $DEFAULT_SRC/localbin/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/localbin/`
for SRCPATH in $LOCALBIN_FILES; do
    TARGETPATH="$HOME/.local/bin/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || (echo -e "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

echo -e "$INFOTAG Checking OS-specifics"
if [ -n "$OS_SRC" ]; then
    echo -e "$INFOTAG Checking $HOME links..."
    HOME_FILES=`find $OS_SRC/homedir/ -maxdepth 1 -type f -o -type d ! -path $OS_SRC/homedir/`
    for SRCPATH in $HOME_FILES; do
        TARGETPATH="$HOME/`basename $SRCPATH`"
        [ -L $TARGETPATH ] || (echo -e "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
    done

    echo -e "$INFOTAG Checking $CONF_TARGET links..."
    CONF_FILES=`find $OS_SRC/config/ -maxdepth 1 -type f -o -type d ! -path $OS_SRC/config/`
    for SRCPATH in $CONF_FILES; do
        TARGETPATH="$CONF_TARGET/`basename $SRCPATH`"
        [ -L $TARGETPATH ] || (echo -e "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
    done

    echo -e "$INFOTAG Checking $LOCALBIN_TARGET links"
    LOCALBIN_FILES=`find $OS_SRC/localbin/ -maxdepth 1 -type f -o -type d ! -path $OS_SRC/localbin/`
    for SRCPATH in $LOCALBIN_FILES; do
        TARGETPATH="$HOME/.local/bin/`basename $SRCPATH`"
        [ -L $TARGETPATH ] || (echo -e "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
    done
else
    echo -e "$INFOTAG no OS specified"
fi
