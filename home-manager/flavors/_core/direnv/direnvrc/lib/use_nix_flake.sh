#!/usr/bin/env bash

use_nix_flake() {
  # """Use nix/devenv shell environment using flakes
  #
  # **NAME**
  #   use_nix_flake [-f FLAKE_FILE] [-d DEVENV_FILE] [-s SHELL_FILE]
  #
  # **DESCRIPTION**
  #
  #   Load nix shell environment. By default, without specifying FLAKE_FILE,
  #   DEVENV_FILE or SHELL_FILE, function will look for them from the direnv root
  #   directory
  #
  # **OPTIONS**
  #
  #   **-f FLAKE_FILE**   specify path to flake.nix, if path start with \'/\`, path is
  #                   considered absolute, else, will be relative to direnv root
  #                   folder
  #
  #   **-d DEVENV_FILE**  specify path to devenv.nix, if path start with \'/\`, path is
  #                   considered absolute, else, will be relative to direnv root
  #                   folder
  #
  #   **-s SHELL_FILE**   specify path to shell.nix, if path start with \'/\`, path is
  #                   considered absolute, else, will be relative to direnv root
  #                   folder
  #
  # **EXAMPLES**
  #   use_nix_flake -f flake.nix -d \"\${PWD}/devenv.nix\""
  #
  # """
  _log "TRACE" "direnv: use_nix_flake()"

  local flake="${PWD}/flake.nix"
  local devenv="${PWD}/devenv.nix"
  local shell="${PWD}/shell.nix"

  while getopts "f:d:s:" option; do
    case "${option}" in
    f)
      [[ "${OPTARG}" =~ ^\/ ]] && flake="${OPTARG}" || flake="${PWD}/${OPTARG}"
      ;;
    d)
      [[ "${OPTARG}" =~ ^\/ ]] && devenv="${OPTARG}" || devenv="${PWD}/${OPTARG}"
      ;;
    s)
      [[ "${OPTARG}" =~ ^\/ ]] && shell="${OPTARG}" || shell="${PWD}/${OPTARG}"
      ;;
    *)
      _log "ERROR" "direnv: Unkown option ${option} for use_nix_flake()"
      ;;
    esac
  done

  if ! [[ -f "${flake}" ]]; then
    _log "DEBUG" "direnv: File **${flake/${HOME}/\~}** does not exist, nothing to do."
    return 1
  elif ! grep -q "devShells" "${flake}"; then
    _log "DEBUG" "direnv: File **${flake/${HOME}/\~}** does not have \`devShells\`"
    return 1
  fi

  _log "INFO" "direnv: 🚀 **${flake/${HOME}/\~}**"
  use flake . --impure 2>/dev/null

  if [[ -f "${devenv}" ]]; then
    _log "INFO" "direnv: 👀 **${devenv/${HOME}/\~}**"
    watch_file "${devenv}"
  fi

  if [[ -f "${shell}" ]]; then
    _log "INFO" "direnv: 👀 **${shell/${HOME}/\~}**"
    watch_file "${shell}"
  fi
}

# vim: ft=bash
