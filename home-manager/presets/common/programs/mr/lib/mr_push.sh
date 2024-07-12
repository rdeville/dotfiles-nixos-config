#!/usr/bin/env bash

mr_push(){
  _log "INFO" "Push **${MR_REPO/${HOME}/\~}**."
  git push --all "$@"
}
