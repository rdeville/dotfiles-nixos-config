#!/usr/bin/env bash

get_yubikey_serial() {
  # """Return the serial of a plugged yubikey
  #
  # **NAME**
  #   get_yubikey_serial
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

  local log_dir="/tmp/kp/${USER}/"
  local lock_file="/tmp/kp/${USER}/kp.lock"
  if [[ -d "${log_dir}" ]]; then
    mkdir -p "${log_dir}"
  fi
  # If current access to keepassdb, i.e. there is the lock file, either from
  # this script or from another script.
  # For instance, my personal script `kp` that is a wrapper around keepassxc-cli
  while [[ -f "${lock_file}" ]]; do
    sleep 2

    # If lock file is older than 2 minutes
    if [[ -f "${lock_file}" ]]; then
      date="$(date '+%s')"
      lock="$(cat "${lock_file}")"
      diff="$((date - ${lock:-${date}}))"
      if [[ -n "${diff}" ]] && [[ "${diff}" -gt 5 ]]; then
        rm "${lock_file}"
      fi
    fi
  done

  # Set lock file to avoid concurrency access
  date '+%s' >"${lock_file}"
  if ! ykman list 2>/dev/null | grep -q 'Serial:'; then
    _log "WARNING" "No yubikey plugged"
    return 1
  fi
  ykman list -s 2>/dev/null
  rm "${lock_file}"
  return 0
}

# vim: ft=bash
