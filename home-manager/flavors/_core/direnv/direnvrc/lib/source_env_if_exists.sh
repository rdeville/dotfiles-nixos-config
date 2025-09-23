#!/usr/bin/env bash

source_env_if_exists() {
  # """Source environment file provided as arguments if file exists
  #
  # **NAME**
  #   source_env_if_exists [FILE]
  #
  #   Check that provided file exists and ensure its SHA sum does not differ
  #   from previously authorization.
  #   If everything is good, load it as an \`.envrc\` file
  #
  # **OPTIONS**
  #   **FILE**: string, path to the file to source
  #
  # **EXAMPLES**
  #   source_env_if_exists .envrc.dev
  #
  # **RETURN CODE**
  #   0 if anything is good
  #   1 if sha of file is not valid or if file does not exist
  #
  # """
  _log "TRACE" "direnv: source_env_if_exists()"

  local file

  [[ $1 =~ ^\/ ]] && file="${1}" || file="${PWD}/${1:-".envrc.local"}"

  if ! [[ -f "${file}" ]]; then
    _log "DEBUG" "direnv: File **${file/${HOME}/\~}** does not exist, nothing to source."
    return 1
  elif ! _check_sha "${file}"; then
    return 1
  fi

  _log "INFO" "direnv: 🔁 **${file/${HOME}/\~}**"
  source_env "${file}"
}

# vim: ft=bash
