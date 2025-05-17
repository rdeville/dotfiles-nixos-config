#!/usr/bin/env bash

# Host and user loop processors
process_user() {
  # shellcheck disable=SC2154
  if type "${action}_user" &>/dev/null; then
    "${action}_user"
  fi
}

process_users() {
  # shellcheck disable=SC2154
  if [[ "${user}" == "none" ]]; then
    return
  elif [[ "${user}" == "all" ]]; then
    for user_path in "${MACHINE_PATH}/${host}"/*; do
      user=$(basename "${user_path}")
      # shellcheck disable=SC2034
      local username=":${user}"
      if [[ -d "${user_path}" ]] && [[ ! "${user}" =~ _.*$ ]]; then
        process_user
      fi
    done
    user="all"
  else
    process_user
  fi
}

process_host() {
  local _user=${user}

  if [[ "${_user}" != "none" ]]; then
    process_users
  fi

  if [[ "${_user}" =~ (all|none) || -z "${_user}" ]] && type "${action}_host" &>/dev/null; then
    user=""

    "${action}_host"
  fi

  user="${_user}"
}

process_hosts() {
  if [[ "${host}" == "none" ]]; then
    _log "WARNING" "Host 'none' specified, nothing to do"
    return
  elif [[ "${host}" == "all" ]]; then
    for host_path in "${MACHINE_PATH}"/*; do
      if [[ -d "${host_path}" ]] && [[ ! "${host}" =~ _.*$ ]]; then
        host=$(basename "${host_path}")
        process_host
      fi
    done
    host="all"
  else
    process_host
  fi
}
