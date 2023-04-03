#!/usr/bin/env bash

PASSFILE="$(dirname -- "$0")/vault_passphrase.gpg"
if [ ! -f "$PASSFILE" ]; then
    openssl rand -hex 32 | head -n1 | gpg --armor --recipient siyuangao@pm.me -e -o $PASSFILE
fi