#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wraper to manage VMs config

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="vm"
DESC="Wrapper to ease building of NixOS VMs"
LEVEL="host"
DEFAULT_ACTION="build"
DEFAULT_HOST="dev"

declare -A OPTIONS
OPTIONS["v"]="--show-trace"
OPTIONS["i"]="--impure"

declare -A ACTIONS
ACTIONS["build"]="Build specified NixOS VM"
ACTIONS["start"]="Start specified NixOS VM"

_compute_cmd() {
  compute_override_inputs

  cmd="nixos-rebuild build-vm --flake .#${host}${cmd_options} ${*}|& nom"
}

_remove_key() {
  rm -f "/tmp/secrets/$host/key.txt"
}

_run() {
  set -e

  local dir="/tmp/nixos-secrets/${host}"
  mkdir -p "${dir}"
  chmod 700 "${dir}"

  local key_file="machines/${host}/keys/age.enc.txt"
  if ! [[ -e "${key_file}" ]]; then
    _log "WARNING" "No key found at ${key_file}."
  else
    _log "INFO" "Loading file from ${key_file}."
    local dest_file="/tmp/nixos-secrets/${host}/key.txt"
    @sops@ -d "${key_file}" > "${dest_file}"
    chmod 600 "${dest_file}"
    trap _remove_key EXIT
  fi
  cmd="${PWD}/result/bin/run-dev-vm"

  _log "INFO" "**Starting** VM based on **${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  eval "${cmd}"
}

build_host() {
  local cmd=""

  _compute_cmd "$@"
  _log "INFO" "**Building** VM based on **${host}** with command : "
  _log "INFO" "${cmd}"
  eval "${cmd}"
}

start_host() {
  local cmd=""

  build_host "$@"
  _run
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  local cmd_options
  parse_args "$@"
  shift $((OPTIND - 1))

  local action="${1}"
  if [[ -n "${action}" ]];
    then shift;
  fi
  action=$(check_option_valid "action" "${action}" "ACTIONS" "${DEFAULT_ACTION}")

  local host=${1}
  if [[ -n ${host} ]]; then
    shift
  fi
  check_host "${DEFAULT_HOST}"

  local cmd=""
  process_hosts "$@"
}

main "$@"
