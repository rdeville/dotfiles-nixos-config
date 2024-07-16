#!/usr/bin/env bash

setup_symlinks() {
  local -n symlinks=$1
  for src in "${!symlinks[@]}"; do
    local dst="${symlinks[src]}"
    if ! [[ -e ${dst} ]]; then
      _log "INFO" "Setup symlinks **${src} -> ${dst}**."
      ln -s "${src}" "${dst}"
    fi
  done
}
