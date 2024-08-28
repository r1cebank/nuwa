#!/usr/bin/env bash

PASSFILE="$(dirname -- "$0")/vault_passphrase.gpg"
if [ ! -f "$PASSFILE" ]; then
    openssl rand -hex 32 | head -n1 | gpg -e -a -r 35CCDC9C649B2C1B -e -o $PASSFILE
fi