#!/usr/bin/env bash

declare -A GITLAB_MIRRORS

GITLAB_MIRRORS["gitlab"]="gitlab.com"

_add_remote() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  local name="$1"
  local https_remote="$2"
  local ssh_remote="$3"

  if git remote -v | grep "${name}" | grep -q "${ssh_remote}" &>/dev/null; then
    _log "INFO" "Remote **${name}** is already setup"
    return
  fi

  response=$(curl -o /dev/null -s -w "%{http_code}" "${https_remote}")

  if ((response != 200)); then
    _log "WARNING" "Repo URL **${https_remote}** does not exists."
    return 1
  fi
  _log "INFO" "Adding **${name}** remote **${ssh_remote}**"
  git remote add "${name}" "${ssh_remote}" &>>"${MR_LOG_FILE}"
}

_setup_gitlab_mirror() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  local domain
  local ssh_remote
  local https_remote

  for name in "${!GITLAB_MIRRORS[@]}"; do
    domain="${GITLAB_MIRRORS[${name}]}"
    ssh_remote="git@${domain}:${org}/${repo}.git"
    https_remote="https://${domain}/${org}/${repo}"
    _add_remote "${name}" "${https_remote}" "${ssh_remote}"
  done

}
_setup_github_mirror() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  local name="github"
  local domain="github.com"
  local repo="${repo//\//\.}"
  local ssh_remote="git@${domain}:${org}/${repo}.git"
  local https_remote="https://${domain}/${org}/${repo}"

  _add_remote "${name}" "${https_remote}" "${ssh_remote}"
}

mr_add_mirror() {
  echo "stack: ${FUNCNAME[0]}()" >>"${MR_LOG_FILE}"
  _log "INFO" "Setup publish remote for **${MR_REPO/${HOME}/\~}**."
  local origin

  origin=$(git remote -v |
    grep origin |
    grep push |
    sed -e "s/origin\s*//g" -e "s/ *(.*)$//g")

  if [[ "${origin}" =~ ^git\@ ]]; then
    # shellcheck disable=SC2001
    domain=$(echo "${origin}" | sed "s|git@\(.*\..*\):.*|\1|g")
    # shellcheck disable=SC2001
    org=$(echo "${origin}" | sed "s|git@.*\..*:\([a-z-]*\)/.*|\1|g")
    # shellcheck disable=SC2001
    repo=$(echo "${origin}" | sed "s|git@.*\..*:[a-z-]*\/\(.*\)\.git$|\1|g")
    _setup_github_mirror
    _setup_gitlab_mirror
  else
    _log "WARNING" "**origin** remote is set to https."
    _log "WARNING" "Public mirror will not be set"
  fi
}
