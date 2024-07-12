#!/usr/bin/env bash

mr_checkout(){
  repo_path=${MR_REPO/${HOME}/\~}
  _log "INFO" "Clone **${repo_path}**."
  git clone -q --recurse-submodules "$@" "${MR_REPO}"
  cd "${MR_REPO}" || return 1
  _log "INFO" "Pull all remote branches"
  if [[ $* =~ --quiet|-q ]]
  then
    git pull --all --quiet;
  else
    git pull --all;
  fi
}
