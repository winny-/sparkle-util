#!/bin/sh

set -e

TESTDIR='test'

[ -e "$TESTDIR" ] && rm -rf "$TESTDIR"
mkdir "$TESTDIR"

dsaparam="$TESTDIR/dsaparam.pem"
dsa_pubkey="$TESTDIR/dsa_pubkey.pem"
dsa_privkey="$TESTDIR/dsa_privkey.pem"
testfile="$TESTDIR/testfile"
sigfile="$TESTDIR/sigfile"
rm -f "$dsaparam" "$dsa_pubkey" "$dsa_privkey"

echo 'Generating keypair:'
printf '        DSA Param: %s\n  DSA Private Key: %s\n   DSA Public Key: %s\n' \
    "$dsaparam" "$dsa_privkey" "$dsa_pubkey"
sh generate_dsa_keypair.sh "$dsaparam" "$dsa_privkey" "$dsa_pubkey"

printf 'Creating mock release file %s.\n' "$testfile"
dd if=/dev/urandom bs=1024 count=10 of="$testfile"

signature="$(sh sign_sparkle_release.sh "$dsa_privkey" "$testfile" | tee "$sigfile")"
printf 'Created DSA signature %s\n' "$signature"
echo 'Verifying...'
sh verify_sparkle_signature.sh "$dsa_pubkey" "$signature" "$testfile"
