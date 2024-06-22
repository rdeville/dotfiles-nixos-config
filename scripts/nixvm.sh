#!/usr/bin/env bash
# """TODO
# """

# shellcheck disable=SC2034
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"
SCRIPTNAME="$(basename "$0")"

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

check_dir(){
  local dir="$1"
  if ! [[ -d "${dir}" ]]
  then
    _log "INFO" "Create directory ${dir}"
    mkdir -p "${dir}"
  fi
}

DATA=(
  "c1-r2-g0"
  "c2-r4-g0"
  "c4-r8-g0"
  "c1-r2-g1"
  "c2-r4-g1"
  "c4-r8-g1"
)

main(){
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  init_logger
  # TODO Change below substitution if need
  local DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  local options=""
  local answer
  local idx
  local vm_configs
  local all_configs
  local module
  local cmd

  cd "${SCRIPTPATH}" || exit 1
  check_dir "/tmp/nixos-shell"

  while getopts 'dim:' opt
  do
    case ${opt} in
      d) # debug
        options+=" --show-trace"
        ;;
      i) # impure
        options+=" --impure"
        ;;

      m)
        module="${OPTARG}"
        ;;
      *)
        _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
        ;;
    esac
  done
  shift $((OPTIND - 1))

  module="${module:-"nixos-shell"}"

  idx=0
  for iConf in "${DATA[@]}"
  do
    vm_configs+="\n  - **${idx}**: ${iConf}"
    idx=$((idx + 1))
  done

  if [[ $# -lt 1 ]]
  then
    msg="Which flavor to use ? [Default: **0**]${vm_configs}"
    _log "INFO" "${msg}"
    read -r answer
    answer=${answer:-0}
  else
    answer=$1
    shift
  fi
  config="${DATA[$answer]}"

  cmd="nix run"
  if [[ "${module}" == "nixos-shell" ]]
  then
    cmd+=" .#nixos-shellConfigurations.${config}.config.system.build.nixos-shell"
  elif [[ "${module}" == "microvm" ]]
  then
    cmd+=" .#microvmConfigurations.${config}.config.microvm.declaredRunner"
  fi
  cmd+=" ${options} $*"
  _log "INFO" "Starting VM with **${module}** and flavor **${config}**"
  _log "DEBUG" "${cmd}"
  eval "${cmd}"
}

main "$@"

# vim: ft=sh
