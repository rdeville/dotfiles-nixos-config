#!/usr/bin/env bash
set -e

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

source "$(git rev-parse --show-toplevel)/scripts/_init_logger.sh"

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  init_logger

  local path
  local cmd="nix fmt "

  path="$(git rev-parse --show-toplevel)"

  if [[ -f "$1" ]]; then
    path=$1
    _log "INFO" "Nix format file ${path}"
  else
    _log "INFO" "Nix format dir ${path}"
  fi

  eval "${cmd} ${path}"
}

main "$@"
