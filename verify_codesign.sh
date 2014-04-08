#!/bin/sh

set -e

APPLICATION="$1"

usage(){
    printf 'Usage: %s APPLICATION\n' "$0"
    echo
    printf 'Example: %s /Applications/TextEdit.app\n' "$0"
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
