#!/usr/bin/env bash

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

_gen_host_keys() {
  for host_path in "${MACHINE_PATH}"/*; do
    if ! [[ "$(basename "${host_path}")" =~ (_templates) ]] &&
      [[ -f "${host_path}/default.nix" ]]; then
      # Generate host age for common secret and user password encrypted files
      ${gen} "$(basename "${host_path}")" none all
    fi
  done
}

_gen_user_keys() {
  # Workstation, allowed to SSH and use a common secret
  ${gen} darth-maul rdeville ssh
  ${gen} darth-maul rdeville age
  # Laptop, allowed to SSH and use a common secret
  ${gen} rey rdeville ssh
  ${gen} rey rdeville age
  # Professional workstation, allowed to SSH and use a common secret
  ${gen} palpatine rdeville ssh
  ${gen} palpatine rdeville age
}

_gen_sops_config() {
  if sps show | yq . &>/dev/null; then
    sps show >"${REPO_DIR}/.sops.yaml"
  else
    _log "ERROR" "There is a misconfiguration when running 'sps show | yq .'"
  fi
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  cd "${REPO_DIR}" || exit 1

  local gen="${REPO_DIR}/scripts/key.sh generate"

  _gen_host_keys
  _gen_user_keys
  _gen_sops_config
}

main "$@"
