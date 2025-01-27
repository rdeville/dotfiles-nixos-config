#!/usr/bin/env bash
# shellcheck disable=SC2034

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="os"
DESC="Wrapper to ease NixOS configuration (build, switch, etc)"
LEVEL="host"
DEFAULT_ACTION="build"
DEFAULT_HOST="$(hostname)"

declare -A OPTIONS
OPTIONS["v"]="--show-trace "
OPTIONS["i"]="--impure "

declare -A ACTIONS
ACTIONS["build"]="Build specified home-manager config"
ACTIONS["switch"]="Switch specified home-manager config"

_compute_cmd() {
  local cmd_options
  compute_override_inputs

  cmd="nh os ${action} -H ${host} ${REPO_DIR}/. -- ${cmd_options}"
}

build_host() {
  local cmd=""

  _compute_cmd
  _log "INFO" "Running **nh home ${action}** for **${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  eval "${cmd}"
}

switch_host() {
  local cmd=""

  _compute_cmd
  _log "INFO" "Running **nh home ${action}** for **${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  eval "${cmd}"
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  parse_args "$@"
  shift $((OPTIND - 1))

  local action="${1}"
  if [[ -n "${action}" ]]; then
    shift
  fi
  action=$(check_option_valid "action" "${action}" "ACTIONS" "build")

  local host=${1}

  if [[ -n ${host} ]]; then
    shift
  fi
  check_host "$(hostname)"

  local cmd=""
  process_hosts
}

main "$@"
