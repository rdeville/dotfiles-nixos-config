#!/usr/bin/env bash

source_up_if_exists() {
  # """Source parent environment file provided as arguments if file exists
  #
  # **NAME**
  #   source_up_if_exists [FILE]
  #
  # **DESCRIPTION**
  #   Check that parent env file exists and ensure its SHA sum does not differ
  #   from previously authorization.
  #
  # **EXAMPLES**
  #   source_up_if_exists
  #
  # **RETURN CODE**
  #   0 if no parent or if anything is good
  #   1 if sha of parent env file is not valid
  #
  # """
  _log "TRACE" "direnv: source_up_if_exists()"

  local parent
  parent="$(cd ../ && find_up .envrc)"

  if [[ -z "${parent}" ]]; then
    _log "DEBUG" "direnv: No more parent direnv file to source."
    return 0
  fi

  if ! _check_sha "${parent}"; then
    _log "WARNING" "direnv: File **${parent}** (and possible parent) will not be sourced."
    return 1
  fi

  _log "INFO" "direnv: 🔁 **${parent/${HOME}/\~}**"
  source_up
}

# vim: ft=bash
