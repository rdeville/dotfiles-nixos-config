#!/usr/bin/env bash

# DESCRIPTION: Script to generate Wireguard Keys

netname=$1

if [[ -z "${netname}" ]]; then
  echo "ERROR - First param must be defined and be the netname"
fi

wg genkey > "wg-${netname}.private.key.enc.txt"
wg pubkey < "wg-${netname}.private.key.enc.txt" > "wg-${netname}.pub"

chmod 0600 "wg-${netname}.private.key.enc.txt"
chmod 0644 "wg-${netname}.pub"
sops encrypt -i "wg-${netname}.private.key.enc.txt"
