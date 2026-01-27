#!/usr/bin/env bash

mr_push() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  _log "INFO" "Push **${MR_REPO/${HOME}/~}**."
  git push --all "$@" >"${MR_LOG_FILE}" 2>&1
}
