#!/usr/bin/env bash
set -e

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

init_logger() {
  local log_file="${XDG_CACHE_HOME:-${HOME}/.cache}/snippets/_log.sh"
  local last_download_file="/tmp/_log.time"
  local delai=14400 # 4 hours
  # shellcheck disable=SC2155
  local curr_time=$(date +%s)
  local time="$((curr_time - $(cat "${last_download_file}" 2>/dev/null || echo "0")))"

  if ! [[ -f "${log_file}" ]] ||
    { [[ -f "${log_file}" ]] && [[ "${time}" -gt "${delai}" ]]; }; then
    if ping -q -c 1 framagit.org &>/dev/null; then
      # shellcheck disable=SC1090
      source <(curl -s https://framagit.org/-/snippets/7183/raw/main/_get_log.sh)
      echo "${curr_time}" >"${last_download_file}"
    else
      echo -e "\033[1;33m[WARNING]\033[0;33m Unable to get last logger version, will use \`echo\`.\033[0m"
      _log() {
        echo "$@"
      }
    fi
  else
    # shellcheck disable=SC1090
    source <(cat "${log_file}")
  fi
}

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
