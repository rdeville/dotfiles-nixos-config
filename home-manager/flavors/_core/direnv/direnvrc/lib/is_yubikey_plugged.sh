#!/usr/bin/env bash

is_yubikey_plugged() {
  # """Check if ykman is installed and Yubi key is plugged
  #
  # **NAME**
  #   is_yubi_plugged
  #
  # **DESCRIPTION**
  #   Check that binary ykman is installed and if ykman list output a serial.
  #
  # **RETURN CODE**
  #   0 if ykman is installed and a yubikey is plugged
  #   1 if ykman is not installer or no yubikey is plugged
  #
  # """
  _log "TRACE" "direnv: is_yubi_plugged()"

  if ! command -v ykman &>/dev/null; then
    _log "WARNING" "**ykman** not installed"
    return 1
  fi

  if ! ykman list 2>/dev/null | grep -q 'Serial:'; then
    _log "WARNING" "No yubikey plugged"
    return 1
  fi
  # rm "${lock_file}"
  return 0
}

# vim: ft=bash
