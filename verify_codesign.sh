#!/bin/sh

set -e

APPLICATION="$1"

usage(){
    scriptname="$(basename "$0")"
    printf 'Usage: %s APPLICATION\n' "$scriptname"
    echo
    printf 'Example: %s /Applications/TextEdit.app\n' "$scriptname"
    exit 1
}

if [ $# -ne 1 -o "x$APPLICATION" = 'x-h' ]; then
    usage
fi

if codesign -v "$APPLICATION"; then
    echo 'Codesigned OK'
else
    exit $?
fi
