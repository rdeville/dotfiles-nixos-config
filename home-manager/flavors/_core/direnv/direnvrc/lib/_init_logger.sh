#!/usr/bin/env bash

_init_logger() {
  # """Initialize bash logger script and allow access to _log() function"""
  local log_file="${XDG_CACHE_HOME:-${HOME}/.cache}/snippets/_log.sh"
  local last_download_file="/tmp/_log.time"
  # 4 hours
  local delai=14400
  # shellcheck disable=SC2155
  local curr_time=$(date +%s)
  local time="$((curr_time - $(cat "${last_download_file}" 2>/dev/null || echo "0")))"

  if ! [[ -f "${log_file}" ]] ||
    [[ $(wc -l ~/.cache/snippets/_log.sh | awk '{print $1}') -eq 0 ]] ||
    { [[ -f "${log_file}" ]] && [[ "${time}" -gt "${delai}" ]]; } ; then
    if ping -q -c 1 -W 1 framagit.org &>/dev/null; then
      # shellcheck disable=SC1090
      source <(curl -s https://framagit.org/-/snippets/7183/raw/main/_get_log.sh)
      echo "${curr_time}" >"${last_download_file}"
    elif [[ -f "${log_file}" ]]; then
      echo -e "\033[1;33m[WARNING]\033[0;33m Unable to get last logger version, will use previous version.\033[0m"
      echo "${curr_time}" >"${last_download_file}"
      # shellcheck disable=SC1090
      source <(cat "${log_file}")
    else
      _log() {
        echo "$@"
      }
    fi
  else
    # shellcheck disable=SC1090
    source <(cat "${log_file}")
  fi
}

_init_logger

# vim: ft=bash
