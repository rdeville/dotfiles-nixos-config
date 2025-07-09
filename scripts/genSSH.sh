#!/usr/bin/env bash

hostname=$1

if [[ -z "${hostname}" ]]; then
  echo "ERROR - First param must be defined and be the hostname"
fi

ssh-keygen -q \
  -C "${hostname}" \
  -t "ed25519" \
  -b 4096 \
  -f "${hostname}-ed25519.enc.asc" \
  -P ""
mv "${hostname}-ed25519.enc.asc.pub" "${hostname}-ed25519.pub"
chmod 0600 "${hostname}-ed25519.enc.asc"
chmod 0644 "${hostname}-ed25519.pub"
sops encrypt -i "${hostname}-ed25519.enc.asc"

ssh-keygen -q \
  -C "${hostname}" \
  -t "rsa" \
  -b 4096 \
  -f "${hostname}-rsa.enc.asc" \
  -P ""
mv "${hostname}-rsa.enc.asc.pub" "${hostname}-rsa.pub"
chmod 0600 "${hostname}-rsa.enc.asc"
chmod 0644 "${hostname}-rsa.pub"
sops encrypt -i "${hostname}-rsa.enc.asc"
