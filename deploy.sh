#!/bin/sh

# Stolen from herrhotzenplotz

# AUTOMATIC DEPLOY SCRIPT
# to deploy to the $HOME folder place the files/folders in the homedir/ folder
# to deploy to the $HOME/.config folder place the files/folders in the config/ folder
# to deploy to the $HOME/.local/bin folder place the files in the localbin/ folder

ECHOCMD="echo -e"

INFOTAG="\033[36m[INFO]\033[0m"
LINKTAG="\033[32m[LINK]\033[0m"

DEFAULT_SRC="all"
if [ "$1" = "debian" ]; then
    OS_SRC="debarch"
elif [ "$1" = "arch" ]; then
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
SSH_TARGET="$HOME/.ssh"

if [ -d "$CONF_TARGET" ]; then
    $ECHOCMD "$INFOTAG $CONF_TARGET exists"
else
    $ECHOCMD "$INFOTAG Creating $CONF_TARGET"
    mkdir -p "$CONF_TARGET"
fi

if [ -d "$LOCALBIN_TARGET" ]; then
    $ECHOCMD "$INFOTAG $LOCALBIN_TARGET exists"
else
    $ECHOCMD "$INFOTAG Creating $LOCALBIN_TARGET"
    mkdir -p "$LOCALBIN_TARGET"
fi

if [ -d "$SSH_TARGET" ]; then
    $ECHOCMD "$INFOTAG $SSH_TARGET exists"
else
    $ECHOCMD "$INFOTAG Creating $SSH_TARGET"
    mkdir -p "$SSH_TARGET"
fi

$ECHOCMD "$INFOTAG Checking $HOME links"
HOME_FILES=`find $DEFAULT_SRC/homedir/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/homedir/`
for SRCPATH in $HOME_FILES; do
    TARGETPATH="$HOME/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

$ECHOCMD "$INFOTAG Checking $CONF_TARGET links"
CONF_FILES=`find $DEFAULT_SRC/config/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/config/`
for SRCPATH in $CONF_FILES; do
    TARGETPATH="$CONF_TARGET/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

$ECHOCMD "$INFOTAG Checking $LOCALBIN_TARGET links"
LOCALBIN_FILES=`find $DEFAULT_SRC/localbin/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/localbin/`
for SRCPATH in $LOCALBIN_FILES; do
    TARGETPATH="$LOCALBIN_TARGET/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

$ECHOCMD "$INFOTAG Checking $SSH_TARGET links"
SSH_FILES=`find $DEFAULT_SRC/ssh/ -maxdepth 1 -type f -o -type d ! -path $DEFAULT_SRC/ssh/`
for SRCPATH in $SSH_FILES; do
    TARGETPATH="$SSH_TARGET/`basename $SRCPATH`"
    [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
done

$ECHOCMD "$INFOTAG Checking OS-specifics"
if [ -n "$OS_SRC" ]; then
    $ECHOCMD "$INFOTAG Checking $HOME links..."
    HOME_FILES=`find $OS_SRC/homedir/ -maxdepth 1 -type f -o -type d ! -path $OS_SRC/homedir/`
    for SRCPATH in $HOME_FILES; do
        TARGETPATH="$HOME/`basename $SRCPATH`"
        [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
    done

    $ECHOCMD "$INFOTAG Checking $CONF_TARGET links..."
    CONF_FILES=`find $OS_SRC/config/ -maxdepth 1 -type f -o -type d ! -path $OS_SRC/config/`
    for SRCPATH in $CONF_FILES; do
        TARGETPATH="$CONF_TARGET/`basename $SRCPATH`"
        [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
    done

    $ECHOCMD "$INFOTAG Checking $LOCALBIN_TARGET links"
    LOCALBIN_FILES=`find $OS_SRC/localbin/ -maxdepth 1 -type f -o -type d ! -path $OS_SRC/localbin/`
    for SRCPATH in $LOCALBIN_FILES; do
        TARGETPATH="$HOME/.local/bin/`basename $SRCPATH`"
        [ -L $TARGETPATH ] || ($ECHOCMD "$LINKTAG " && ln -vs "$PWD/$SRCPATH" "$TARGETPATH")
    done
else
    $ECHOCMD "$INFOTAG no OS specified"
fi
