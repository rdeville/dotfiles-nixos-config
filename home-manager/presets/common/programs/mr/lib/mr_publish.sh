#!/usr/bin/env bash

_checkout_back() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"

  if [[ "${curr_branch}" != "${main_branch}" ]]; then
    _log "WARNING" "Checkout back to previous branch **${curr_branch}**"
    git checkout "${curr_branch}" &>>"${MR_LOG_FILE}"
    stash_idx=$(git stash list | grep "${stash_message}" | cut -d ":" -f 1)

    if [[ -n "${stash_idx}" ]]; then
      _log "WARNING" "Unstashing modification"
      git stash pop "${stash_idx}" &>>"${MR_LOG_FILE}"
    fi
  fi
}

_checkout_main() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"

  if [[ "${curr_branch}" != "${main_branch}" ]]; then
    _log "WARNING" "Not on main branch, will stash and checkout"
    if ! git diff --quiet; then
      _log "WARNING" "Stashing modification before checkout"
      git stash push -m "${stash_message}" &>>"${MR_LOG_FILE}"
    fi
    _log "WARNING" "Checkout to **main**"
    git checkout "${main_branch}" &>>"${MR_LOG_FILE}"
  fi
}

_pull_main() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  _log "INFO" "Ensuring local branch **main is up-to-date**"

  if ! git pull "origin" "main" &>>"${MR_LOG_FILE}"; then
    _log "ERROR" "Unable to pull main, **aborting publishing**"
    _checkout_back
    return 1
  fi
}

_publish() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"

  for remote in $(git remote -v | grep push | sed -e "s/\s*git@.*\s*(.*)$//g"); do
    if [[ "${remote}" != "origin" ]]; then
      _log "INFO" "Publishing on **${remote}**"
      git push "${remote}" "main" &>>"${MR_LOG_FILE}"
      git push --tags "${remote}" "main" &>>"${MR_LOG_FILE}"
    fi
  done
}

mr_publish() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  _log "INFO" "Publish **${MR_REPO/${HOME}/\~}**."

  local stash_message="Autostash before publish"
  local main_branch="main"
  local curr_branch
  curr_branch="$(git rev-parse --abbrev-ref HEAD)"

  _checkout_main
  if ! _pull_main; then
    return 1
  fi
  _publish
  _checkout_back
}
