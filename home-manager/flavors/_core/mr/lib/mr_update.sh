#!/usr/bin/env bash

mr_update() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  _log "INFO" "Pull **${MR_REPO/${HOME}/~}**."
  git pull "$@" >"${MR_LOG_FILE}" 2>&1
}
