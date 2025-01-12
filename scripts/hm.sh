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

  local local_inputs_file
  local profile="-c ${USER}@${HOST}"
  local action="build"

  local_inputs_file="$(git rev-parse --show-toplevel)/scripts/local_inputs.sh"

  if [[ -f "$1" ]]; then
    local_inputs_file="$1"
    shift
  fi

  # shellcheck source=./local_inputs.sh
  source "${local_inputs_file}"

  while getopts "vip:" opt; do
    _log "DEBUG" "Process args : ${opt}"
    case ${opt} in
    v) # verbosity
      options+=" --show-trace"
      ;;
    i) # impure
      options+=" --impure"
      ;;
    p) # profile
      profile="-c ${OPTARG}"
      shift
      ;;
    *)
      _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
      exit 1
      ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ -n "$1" ]]; then
    action="$1"
    shift
  fi

  # shellcheck disable=2154
  for input in "${!inputs[@]}"; do
    options+=" --override-input ${input} ${inputs[$input]}"
  done

  cmd+="nh home ${action} ${profile} . -- \
    --extra-experimental-features \"nix-command flakes\"\
    ${options}"

  cmd_fmt="nix fmt ."
  _log "INFO" "Formatting files with command:"
  _log "INFO" "${cmd_fmt}"
  eval "${cmd_fmt}"
  _log "INFO" "Running **nh home ${action}** for **${profile/-c /}** with command : "
  _log "INFO" "${cmd//  /}"
  eval "${cmd}"
}

main "$@"
