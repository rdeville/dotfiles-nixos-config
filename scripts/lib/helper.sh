#!/usr/bin/env bash

BOLD="$(printf "\033[1m")"
YELLOW="$(printf "\033[33m")"
GREEN="$(printf "\033[32m")"
RESET="$(printf "\033[0m")"

# Script show helper functions
_help_section() {
  local section_name=$1
  echo "
${BOLD}${section_name}${RESET}:"
}

_help_name() {
  _help_section "NAME"
  echo "  ${NAME} - ${DESC}"
}

_help_usage() {
  _help_section "USAGE"
  if [[ -n "${LEVEL}" ]]; then
    echo "  ${NAME} [OPTIONS] ${BOLD}ACTIONS${RESET} ${lvl[$LEVEL]}"
  else
    echo "  ${NAME} [OPTIONS] ${BOLD}ACTIONS${RESET}"
  fi
}

_help_option() {
  _help_section "OPTIONS"
  echo "  ${YELLOW}${BOLD}-h${RESET}: Show this help"

  if [[ -n "${OPTIONS[*]}" ]]; then
    for opt in "${!OPTIONS[@]}"; do
      echo "  ${YELLOW}${BOLD}-${opt}${RESET}: Add \`${OPTIONS[$opt]}\` to final command"
    done
  fi
}

_help_action() {
  if [[ -n "${ACTIONS[*]}" ]]; then
    _help_section "ACTIONS"
    for opt in "${!ACTIONS[@]}"; do
      if [[ "${opt}" == "${DEFAULT_ACTION}" ]]; then
        echo "  ${YELLOW}${BOLD}${opt}${RESET}${GREEN}${BOLD}: ${ACTIONS[$opt]} (default)${RESET}"
      else
        echo "  ${YELLOW}${BOLD}${opt}${RESET}: ${ACTIONS[$opt]}"
      fi
    done
  fi
}

_help_type() {
  if [[ -n "${TYPES[*]}" ]]; then
    _help_section "TYPES"
    for opt in "${!TYPES[@]}"; do
      if [[ "${opt}" == "${DEFAULT_TYPE}" ]]; then
        echo "  ${YELLOW}${BOLD}${opt}${RESET}${GREEN}${BOLD}: ${TYPES[$opt]} (default)${RESET}"
      else
        echo "  ${YELLOW}${BOLD}${opt}${RESET}: ${TYPES[$opt]}"
      fi
    done
  fi
}

help() {
  declare -A lvl

  if [[ -n ${DEFAULT_HOST} ]]; then
    if [[ "${DEFAULT_HOST}" == all ]]; then
      hosts_opts="[HOSTNAME|${GREEN}${BOLD}all${RESET}|none]"
    else
      hosts_opts="[HOSTNAME|all|none|${GREEN}${BOLD}${DEFAULT_HOST}${RESET}]"
    fi
  else
    hosts_opts="[HOSTNAME|all|none]"
  fi

  if [[ -n ${DEFAULT_USER} ]]; then
    if [[ "${DEFAULT_USER}" == all ]]; then
      users_opts="[USERNAME|${GREEN}${BOLD}all${RESET}|none]"
    else
      users_opts="[USERNAME|all|none|${GREEN}${BOLD}${DEFAULT_USER}${RESET}]"
    fi
  else
    users_opts="[USERNAME|all|none]"
  fi

  if [[ -n ${DEFAULT_TYPE} ]]; then
    if [[ "${DEFAULT_TYPE}" == all ]]; then
      types_opts="[TYPE|${GREEN}${BOLD}all${RESET}|none]"
    else
      types_opts="[TYPE|all|none|${GREEN}${BOLD}${DEFAULT_TYPE}${RESET}]"
    fi
  else
    types_opts="[TYPE|all|none]"
  fi

  lvl["host"]="${hosts_opts}"
  lvl["user"]="${hosts_opts} ${users_opts}"
  lvl["type"]="${hosts_opts} ${users_opts} ${types_opts}"

  cat <<EOM
$(_help_name)
$(_help_usage)
$(_help_option)
$(_help_action)
$(_help_type)
EOM
  exit
}
