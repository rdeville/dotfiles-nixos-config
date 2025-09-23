#!/usr/bin/env bash

use_tmux() {
  # """If tmux environment variable sets ask to load tmux session
  #
  # **NAME**
  #   use_tmux
  #
  # **RETURN CODE**
  #   0 if anything is good
  #
  # """
  _log "TRACE" "direnv: use_tmux()"

  if [[ "${PWD}" != "${HOME}" ]] && [[ "${TMUXP_CONFIG}" == "home" ]]; then
    # Unset my tmuxp home configuration
    TMUXP_CONFIG=""
  fi

  if [[ -z "${VIMRUNTIME}" ]] &&
    [[ "${PWD}" != "${HOME}" ]] &&
    [[ -n "${TMUXP_SESSION_NAME}" ]] &&
    [[ "$(tmux display-message -p '#S')" != "${TMUXP_SESSION_NAME}" ]]; then
    # shellcheck disable=SC2210
    _log "WARNING" "direnv: Load tmux session **${TMUXP_SESSION_NAME}** ? [**Y**/n]"
    read -r answer
    answer=${answer:-y}
    answer=$(echo "${answer}" | tr '[:upper:]' '[:lower:]')
    if [[ "${answer}" =~ (y|ye|yes) ]]; then
      TMUXP_CONFIG="${TMUXP_CONFIG:-"default"}"
      _log "TRACE" "Loading tmuxp configuration **${TMUXP_CONFIG}**"
      tmuxp load -y "${TMUXP_CONFIG}"
    fi
  fi
}

# vim: ft=bash
