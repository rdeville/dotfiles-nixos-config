#!/usr/bin/env bash

dotenv_if_exists() {
  # """Source dot environment file '.env' provided as arguments if file exists
  #
  # **NAME**
  #   dotenv_if_exists [FILE]
  #
  # **DESCRIPTION**
  #   Check that provided dot file exists load it in the current environment
  #   and watch if it exits.
  #
  # **OPTIONS**
  #   **FILE**: string (optional), relative path to the file to source, `.env`
  #             if not specified
  #
  # **EXAMPLES**
  #   dotenv_if_exists .env
  #
  # **RETURN CODE**
  #   0 anyway
  #
  # """
  _log "TRACE" "direnv: dotenv_if_exists()"

  # shellcheck disable=SC2155
  local direnv="$(which direnv)"
  local file

  [[ "${1}" =~ ^\/ ]] && file="${1}" || file="${PWD}/${1:-".env"}"

  if ! [[ -f ${file} ]]; then
    _log "DEBUG" "direnv: File **${file/${HOME}/\~}** does not exist, nothing to load."
    return 1
  fi

  _log "INFO" "direnv: 🌍 **${file/${HOME}/\~}**"
  eval "$("$direnv" dotenv bash "${file}")"

  _log "INFO" "direnv: 👀 **${file/${HOME}/\~}**"
  watch_file "${file}"
}

# vim: ft=bash
