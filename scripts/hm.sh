#!/usr/bin/env bash

# shellcheck disable=SC2034
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
SCRIPTNAME="$(basename "$0")"
set -e

init_logger(){
  local log_file="${XDG_CACHE_HOME:-${HOME}/.cache}/snippets/_log.sh"
  local last_download_file="/tmp/_log.time"
  local delai=14400             # 4 hours
  # shellcheck disable=SC2155
  local curr_time=$(date +%s)
  local time="$(( curr_time - $(cat "${last_download_file}" 2>/dev/null || echo "0") ))"

  if ! [[ -f "${log_file}" ]] \
    || { [[ -f "${log_file}" ]] && [[ "${time}" -gt "${delai}" ]]; }
  then
    if ping -q -c 1 framagit.org &> /dev/null
    then
      # shellcheck disable=SC1090
      source <(curl -s https://framagit.org/-/snippets/7183/raw/main/_get_log.sh)
      echo "${curr_time}" > "${last_download_file}"
    else
      echo -e "\033[1;33m[WARNING]\033[0;33m Unable to get last logger version, will use \`echo\`.\033[0m"
      _log(){
        echo "$@"
      }
    fi
  else
    # shellcheck disable=SC1090
    source <(cat "${log_file}")
  fi
}

main(){
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  init_logger

  local profile="${USER}@${HOST}"
  local action="build"
  if [[ -n "$1" ]]
  then
    action="$1"
    shift
  fi

  if which home-manager &>/dev/null
  then
    cmd="$(which home-manager)"
  else
    cmd="nix run --extra-experimental-features 'nix-command flakes' .#home-manager --"
  fi
  while getopts "dip:" opt
  do
    _log "DEBUG" "Process args : ${opt}"
    case ${opt} in
      d) # debug
        cmd+=" --show-trace"
        ;;
      i) # impure
        cmd+=" --impure"
        ;;
      p) # profile
        profile="${OPTARG}"
        shift
        ;;
      *)
        _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
        exit 1
        ;;
    esac
  done
  shift $((OPTIND-1))

  if [[ "${action}" == "update" ]]
  then
    _log "INFO" "Update current flakes before build :"
    _log "DEBUG" "${cmd//  /}"
    nix flake update
    action="build"
  fi

  cmd+=" ${action} \
    --extra-experimental-features \"nix-command flakes\" \
    $* \
    --flake .#${profile} "


  _log "INFO" "Running **home-manager ${action}** for **${profile}** with command : "
  _log "DEBUG" "${cmd//  /}"
  eval "${cmd}"

  if [[ "${action}" == "build" ]]
  then
      $(which nvd) diff ~/.local/state/nix/profiles/home-manager "${PWD}/result"
  fi
}

main "$@"
