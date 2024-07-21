#!/usr/bin/env bash

mr_checkout() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"

  _log "INFO" "Clone **${MR_REPO/${HOME}/\~}**."
  git clone -q --recurse-submodules "$@" "${MR_REPO}" &>>"${MR_LOG_FILE}"
  cd "${MR_REPO}" || return 1

  _log "INFO" "Pull all remote branches"
  if [[ $* =~ --quiet|-q ]]; then
    git pull --all --quiet &>>"${MR_LOG_FILE}"
  else
    git pull --all &>>"${MR_LOG_FILE}"
  fi
}
