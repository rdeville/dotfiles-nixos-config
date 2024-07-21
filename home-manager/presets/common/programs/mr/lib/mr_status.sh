#!/usr/bin/env bash

mr_status() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  _log "INFO" "Status **${MR_REPO/${HOME}/\~}**."
  git status -s "$@" || true
  git --no-pager log --branches --not --remotes --simplify-by-decoration --decorate --oneline || true
  git --no-pager stash list
}
