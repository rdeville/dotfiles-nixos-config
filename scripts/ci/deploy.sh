#!/usr/bin/env bash

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

usage() {
  cat <<EOM
./deploy.sh HOSTNAME USER [IP|DNS]

Three arguments are required:

* HOSTNAME: The hostname of the machine to install, must be a existing host in
  folder 'machines'
* USER: User to use for the SSH connexion to install the machine
* IP: The IP or DNS of the machine to install, if not specified, will try to use 'USER@HOSTNAME.tekunix.private'
EOM
}

_check_host_valid() {
  if ! [[ -d ${MACHINE_PATH}/${hostname} ]]; then
    _log "ERROR" "Machine **${hostname}** not defined, nothing to do"
    return 1
  elif ! [[ -f ${MACHINE_PATH}/${hostname}/default.nix ]]; then
    _log "ERROR" "Machine **${hostname}** exists but does not have default.nix, nothing to do"
    return 1
  fi
}

_check_age_key() {
  local age_target_path="/etc/ssh/.age.key"
  local age_target="${tmp}/age.key.target"
  local age_repo_path="${MACHINE_PATH}/${hostname}/_keys/age.enc.txt"
  local age_repo="${tmp}/age.key.repo"
  local error="false"
  local username

  scp "${user}@${ip}:${age_target_path}" "${age_target}" &>/dev/null
  sops -d "${age_repo_path}" >"${age_repo}"
  chmod 0600 "${age_target}" "${age_repo}"

  if ! diff "${age_target}" "${age_repo}" &>/dev/null; then
    _log "ERROR" "Age key on target differs from the key in this repo config"
    _log "ERROR" "Please upload valid age key for the host before continue"
    error="true"
  fi

  for _user in "${MACHINE_PATH}/${hostname}"/*/; do
    username=$(basename "${_user}")

    if [[ "${username}" == "root" ]]; then
      age_target_path="/${username}/.cache/.age.key"
    else
      age_target_path="/home/${username}/.cache/.age.key"
    fi

    age_repo_path="${_user}_keys/age.enc.txt"

    if [[ -f "${age_repo_path}" ]]; then
      scp "${username}@${ip}:${age_target_path}" "${age_target}" &>/dev/null
      sops -d "${age_repo_path}" >"${age_repo}"
      chmod 0600 "${age_target}" "${age_repo}"

      if ! diff "${age_target}" "${age_repo}" &>/dev/null; then
        _log "ERROR" "Age key for user ${username} on target differs from the key in this repo config"
        _log "ERROR" "Please upload valid age key to host for user ${username} before continue"
        error="true"
      fi
    fi
  done

  if [[ "${error}" == "true" ]]; then
    return 1
  fi
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  if [[ "$#" -lt 1 ]]; then
    usage
    return 1
  fi

  local hostname="$1"
  local user="${2:-"${USER}"}"
  local ip="${3:-${hostname}.tekunix.private}"
  local tmp="/tmp/host-key/${hostname}"
  local user_has_secret=false

  if ! [[ -d "${tmp}" ]]; then
    mkdir -p "${tmp}"
  fi

  if ! _check_host_valid || ! _check_age_key; then
    rm -rf "${tmp}"
    return 1
  fi

  if ! os build "${hostname}"; then
    _log "ERROR" "An error occurs during build of **${hostname}**"
    rm -rf "${tmp}"
    return 1
  fi

  if ! nixos-rebuild switch \
    --flake ".#${hostname}" \
    --target-host "${user}@${ip}" \
    --sudo; then
    _log "ERROR" "An error occurs during switch of NixOS configuration for **${hostname}**"
    rm -rf "${tmp}"
    return 1
  fi

  rm -rf "${tmp}"
}

main "$@"
