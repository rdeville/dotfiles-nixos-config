#!/usr/bin/env bash
# """Setup script to install symlinks if specified
# """

# shellcheck disable=SC2034
SCRIPTPATH="$( cd -- "$(dirname "$0")" &>/dev/null || exit 1 ; pwd -P )"
SCRIPTNAME="$(basename "$0")"

init_setup(){
  local setup_file="/tmp/_setup.sh"
  if ping -q -c 1 -W 1 framagit.org &> /dev/null
  then
    # shellcheck disable=SC1090
    source <(curl -s https://framagit.org/-/snippets/7207/raw/main/_get_setup.sh)
  elif [[ -f "${setup_file}" ]]
  then
    echo -e "\e[1;32m[INFO]\e[0m\e[32m ${SCRIPTNAME}: Not able to ping \e[1;31mframagit.org, will source existing **${setup_file}**\e[0m"
    # shellcheck disable=SC1090
    source <(cat "${setup_file}")
  else
    echo -e "\e[1;31m[ERROR]\e[0m\e[31m ${SCRIPTNAME}: Not able to ping \e[1;31mframagit.org\e[0m"
    echo -e "\e[1;31m[ERROR]\e[0m\e[31m ${SCRIPTNAME}: And setup lib file ${setup_file} does not exists.\e[0m"
    echo -e "\e[1;31m[ERROR]\e[0m\e[31m ${SCRIPTNAME}: Logger not available, script will now exit\e[0m"
    exit 1
  fi
}

main(){
  local DEBUG_LEVEL="${SETUP_DEBUG_LEVEL:-"INFO"}"
  init_setup
  setup "LINKS"
}

CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}"

declare -A LINKS
# LINKS["<SOURCE>"]="<DEST>"
LINKS["${CONFIG_DIR}/nixos"]="${SCRIPTPATH}"

main "$@"

# vim: ft=sh
