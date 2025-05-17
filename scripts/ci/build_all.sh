#!/usr/bin/env bash

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

cd "${REPO_DIR}" || exit 1

_os_build() {
  _log "INFO" "Building NixOS for **${user}@${host}**"
  if ! os build "${host}" &>/dev/null; then
    _log "ERROR" "Unable to build NixOS for **${host}**"
  fi
}

_hm_build() {
  for user_path in "${host_path}"/*; do
    user="$(basename "${user_path}")"

    if ! [[ "${user}" =~ _.* ]]; then
      _log "INFO" "Building Home-Manager for **${user}@${host}**"
      if ! hm build "${host}" "${user}" &>/dev/null; then
        _log "ERROR" "Unable to build Home-Manager for **${user}@${host}**"
      fi
    fi
  done
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  for host_path in "${MACHINE_PATH}"/*; do
    host="$(basename "${host_path}")"

    if ! [[ "${host}" =~ (_templates*) ]]; then
      if [[ -f "${host_path}/default.nix" ]]; then
        _os_build
      else
        _hm_build
      fi
    fi
  done
}

main "$@"
