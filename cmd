#!/usr/bin/env bash

if [ -z "$WINDOWS_ROOT" ]; then
    WINDOWS_ROOT=./windows
fi

if [ ! -d "$WINDOWS_ROOT" ]; then
    echo "ERROR: Windows files directory not found"
    exit 1
fi

if [ -z "$WINE" ]; then
    WINE=$(command -v wine)

    if [ $? != 0 ]; then
        echo "ERROR: Wine not found! Set WINE environment variable to path to its binary or add it to your PATH"
        exit 1
    fi
fi

if [ ! -d wineprefix ]; then
    echo "Creating Wine prefix..."
    WINEPREFIX="$PWD/wineprefix" WINEDEBUG=-all wineboot -u
fi
