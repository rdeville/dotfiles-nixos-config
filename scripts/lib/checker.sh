#!/usr/bin/env bash

# Variable checks
check_option_valid() {
  local opt_name="$1"
  local opt_val="$2"
  local opts_array_name="$3"
  local -n opts_array="$3"
  local default="$4"
  local opt_re

  opt_re=$(show_options_regexp)

  if [[ -n "${default}" && ! "${default}" =~ ^(${opt_re})$ ]]; then
    _log "ERROR" "Please specify valid default ${opts_array_name,,} option among following ones:"
    for opt in "${!opts_array[@]}"; do
      _log "ERROR" " - ${opt}"
    done
    _log "ERROR" "Current default value: ${default}"
    exit 1
  fi

  if [[ "${opt_val}" =~ ^(${opt_re})$ ]]; then
    echo "${opt_val}"
  elif [[ -z "${opt_val}" ]]; then
    _log "WARNING" "No value for ${opt_name} provided, will use default value: **\`${default}\`**."
    echo "${default}"
  elif [[ -n "${default}" ]]; then
    _log "WARNING" "Invalid value \`${opt_val,,}\` for option \`${opt_name}\`."
    _log "WARNING" "Will use default value: **\`${default}\`**."
    echo "${default}"
  else
    _log "ERROR" "Please specify valid value ${opts_array_name,,} option among following ones:"
    for option in "${!opts_array[@]}"; do
      _log "ERROR" " - ${option}"
    done
    help
  fi
}

check_host() {
  local default="${1:-"none"}"

  if [[ -z "${host}" ]]; then
    host=${default}
  else
    if ! [[ "${host}" =~ ^(none|all)$ ]] && ! [[ -d "${MACHINE_PATH}/${host}" ]]; then
      _log "ERROR" "Machine **${host}** does not exists in machines/"
      exit 1
    fi
    shift
  fi
}

check_user() {
  local default="${1:"none"}"

  if [[ -n "${user}" ]] &&
    ! [[ "${user}" =~ ^(none|all)$ ]]; then
    if ! [[ -d "${MACHINE_PATH}/${host}/users/${user}" ]]; then
      _log "ERROR" "User **${user}@${host}** does not exists in machines/${host}/users"
      exit 1
    fi
    shift
  elif [[ -z "${user}" ]]; then
    user="${default}"
  fi
}
