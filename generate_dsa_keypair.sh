#!/bin/sh

set -e

: ${OPENSSL:='/usr/bin/openssl'}
DSA_PARAM="$1"
DSA_PRIVKEY="$2"
DSA_PUBKEY="$3"

usage() {
    scriptname="$(basename "$0")"
    printf 'Usage: %s DSA_PARAM DSA_PRIVKEY DSA_PUBKEY\n' "$scriptname"
    echo 'Override environment variable OPENSSL to use different OpenSSL.'
    echo
    printf 'Example: %s dsaparam.pem dsa_privkey.pem dsa_pubkey.pem\n' "$scriptname"
    exit 1
}

if [ $# -ne 3 ]; then
    usage
fi

"$OPENSSL" dsaparam 1024 < /dev/urandom > "$DSA_PARAM"
"$OPENSSL" gendsa "$DSA_PARAM" -out "$DSA_PRIVKEY"
"$OPENSSL" dsa -in "$DSA_PRIVKEY" -pubout -out "$DSA_PUBKEY"
