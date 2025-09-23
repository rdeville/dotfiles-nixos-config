#!/usr/bin/env bash

use_devbox() {
  # """If devbox environment exists, load and watch it
  #
  # **NAME**
  #   use_devbox
  #
  # **DESCRIPTION**
  #   Load file provided as arguments or devbox.json relative to direnv root as
  #   a \`devbox.json\` environment
  #
  # **OPTIONS**
  #   **FILE**: string, path to the devbox.json file
  #
  # **EXAMPLES**
  #   use_devbox filename.json
  #
  # **RETURN CODE**
  #   1 if devbox json file does not exists
  #   0 if anything is good
  #
  # """
  _log "TRACE" "direnv: use_devbox()"

  local file

  [[ $1 =~ ^\/ ]] && file="${1}" || file="${PWD}/${1:-"devbox.json"}"

  if ! [[ -f "${file}" ]]; then
    _log "DEBUG" "direnv: File **${file/${HOME}/\~}** does not exist, nothing to do."
    return 1
  fi

  _log "INFO" "direnv: 🚀 **${file/${HOME}/\~}**"
  eval "$(devbox shellenv --init-hook --install --no-refresh-alias)"

  _log "INFO" "direnv: 👀 **${file/${HOME}/\~}**."
  watch_file "devbox.json"
}

# vim: ft=bash
