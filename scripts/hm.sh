#!/usr/bin/env bash
#shellcheck disable=SC2034

# DESCRIPTION: Wraper to manage Home-Manager config

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="iso"
DESC="Wrapper to ease Home-Manager configuration (build, switch, etc)"
LEVEL="user"
DEFAULT_ACTION="build"
DEFAULT_HOST="$(hostname)"
DEFAULT_USER="$(whoami)"

declare -A OPTIONS
OPTIONS["v"]="--show-trace "
OPTIONS["i"]="--impure "

declare -A ACTIONS
ACTIONS["build"]="Build specified home-manager config"
ACTIONS["switch"]="Switch specified home-manager config"

_compute_cmd() {
  local cmd_options="\\
  --extra-experimental-features flakes \\
  --extra-experimental-features nix-command"
  compute_override_inputs

  cmd="nh home ${action} -c ${user}@${host} ${REPO_DIR}/. -- ${cmd_options} ${*}"
}

build_user() {
  local cmd=""

  _compute_cmd "${@}"
  _log "INFO" "Running **nh home ${action}** for **${user}@${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  eval "${cmd}"
}

switch_user() {
  local cmd=""

  _compute_cmd "${@}"
  _log "INFO" "Running **nh home ${action}** for **${user}@${host}** with command : "
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
  if [[ -n "${action}" ]];
    then shift;
  fi
  action=$(check_option_valid "action" "${action}" "ACTIONS" "${DEFAULT_ACTION}")

  local host=${1:-"${DEFAULT_HOST}"}
  if [[ -n ${host} ]]; then
    shift
  fi
  check_host "${host}"

  local user=${1:-"${DEFAULT_USER}"}
  local tmp_user=${user}
  if [[ -n ${user} ]]; then
    shift
  fi
  check_user "${user}"
  user="${tmp_user}"

  local cmd=""
  process_hosts "$@"
}

main "$@"
