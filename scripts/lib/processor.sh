#!/usr/bin/env bash

# Host and user loop processors
process_user() {
  # shellcheck disable=SC2154
  if type "${action}_user" &>/dev/null; then
    "${action}_user" "$@"
  fi
}

process_users() {
  # shellcheck disable=SC2154
  if [[ "${user}" == "none" ]]; then
    return
  elif [[ "${user}" == "all" ]]; then
    for user_path in "${MACHINE_PATH}/${host}"/*; do
      user=$(basename "${user_path}")
      if [[ -d "${user_path}" ]] && [[ ! "${user}" =~ ^(keys|assets)$ ]]; then
        process_user "$@"
      fi
    done
    user="all"
  else
    process_user "$@"
  fi
}

process_host() {

  process_users "$@"

  if type "${action}_host" &>/dev/null; then
    "${action}_host" "$@"
  fi
}

process_hosts() {
  if [[ "${host}" == "none" ]]; then
    return
  elif [[ "${host}" == "all" ]]; then
    for host_path in "${MACHINE_PATH}"/*; do
      if [[ -d "${host_path}" ]] && [[ ! "${host}" =~ ^(keys|assets)$ ]]; then
        host=$(basename "${host_path}")
        process_host "$@"
      fi
    done
    host="all"
  else
    process_host "$@"
  fi
}
