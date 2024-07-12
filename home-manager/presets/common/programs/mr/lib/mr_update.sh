#!/usr/bin/env bash

mr_update(){
  _log "INFO" "Pull **${MR_REPO/${HOME}/\~}**."
  git pull "$@"
}
