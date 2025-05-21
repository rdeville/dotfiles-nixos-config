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
./install.sh HOSTNAME USER (IP|DNS)

Three arguments are required:

* HOSTNAME: The hostname of the machine to install, must be a existing host in
  folder 'machines'
* USER: User to use for the SSH connexion to install the machine
* IP: The IP or DNS of the machine to install
EOM
}

_put_target_disk_encryption_key() {
  if [[ -f "${MACHINE_PATH}/${hostname}/keys/disk.key.enc.txt" ]]; then
    _log "INFO" "Machine have encrypted disk, preparing key on the target"

    sops -d "${MACHINE_PATH}/${HOSTNAME}/keys/disk.key.enc.txt" >"/tmp/disk.key"
    scp /tmp/disk.key "${url}:/tmp/disk.key"
    rm "/tmp/disk.key"
  fi
}

_format_target() {
  _log "INFO" "Running kexec and disko to format target"
  nix run github:nix-community/nixos-anywhere -- \
    --flake ".#${hostname}" \
    --target-host "${url}" \
    --phases kexec,disko
}

_prepare_host_encryption_key() {
  _log "INFO" "Prepare host and usersencryption keys"
  local tmp_host="${tmp}/etc/ssh"
  local tmp_user
  local username
  local key

  mkdir -p "${tmp_host}"
  sops -d "${MACHINE_PATH}/${HOSTNAME}/keys/age.enc.txt" >"${tmp_host}/.age.key"

  for user in "${MACHINE_PATH}/${HOSTNAME}/"*/; do
    username=$(basename "${user}")
    key="${user}/_keys/age.enc.txt"

    if [[ -f "${key}" ]]; then
      user_has_secret=true

      case "${username}" in
      root)
        tmp_user="${tmp}/${username}/.cache"
        ;;
      *)
        tmp_user="${tmp}/home/${username}/.cache"
        ;;
      esac

      mkdir -p "${tmp_user}"
      sops -d "${key}" >"${tmp_user}/.age.key"
    fi
  done
}

_install_nixos() {
  _log "INFO" "Running nixos-anywhere and install NixOS"

  nix run github:nix-community/nixos-anywhere -- \
    --flake ".#${hostname}" \
    --target-host "${url}" \
    --phases install \
    --build-on local \
    --extra-files "${tmp}"

  ssh "${url}" -c "chmod 0600 /mnt/etc/ssh/.age.key"
}

_restart_and_wait() {
  _log "INFO" "Reboot target"
  nix run github:nix-community/nixos-anywhere -- \
    --flake ".#${hostname}" \
    --target-host "${url}" \
    --phases reboot \
    --build-on local

  local timeout=300
  local timeoutDate=$(($(date +%s) + timeout))
  _log "INFO" "Waiting for target to restart, up to 5 minutes"
  while [[ "$(date +%s)" -lt ${timeoutDate} ]] && ! ping -q -c 4 -t 1 "${ip}"; do
    _log "DEBUG" "No ping response, waiting for 15 more seconds"
    sleep 15
  done
}

_update_user_key_permission() {
  for user in "${MACHINE_PATH}/${hostname}/"*/; do
    username=$(basename "${user}")
    key="${user}/_keys/age.enc.txt"

    if [[ -f "${key}" ]]; then
      case "${username}" in
      root)
        ssh "${url}" -c "sudo chown -R ${username}:users /root/.cache/.age.key"
        ;;
      *)
        ssh "${url}" -c "sudo chown -R ${username}:users /home/${username}/.cache/.age.key"
        ;;
      esac
    fi
  done
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  if [[ "$#" -ne 3 ]]; then
    usage
    return 1
  fi

  local hostname="$1"
  local user="$2"
  local ip="$3"
  local url="${user}@${ip}"
  local tmp="/tmp/host-key/${hostname}"
  local user_has_secret=false

  if ! ping -q -c 4 -t "${ip}" &>/dev/null; then
    _log "ERROR" "Target ${ip} does not respond to ping, nothing to do"
    return 1
  fi

  _put_target_disk_encryption_key
  _format_target
  _prepare_host_encryption_key
  _install_nixos
  _update_host_key_ownership
  _restart_and_wait

  # Clean temporary file that contains unencrypted files
  rm -rf "${tmp}"

  if [[ "${user_has_secret}" == "true" ]]; then
    _update_user_key_permission
  fi
}

main "$@"
