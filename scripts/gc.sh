#!/usr/bin/env bash
#shellcheck disable=SC2034

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="iso"
DESC="Wrapper to ease commit change to host and user config"
LEVEL="type"
DEFAULT_HOST="all"
DEFAULT_USER="all"
DEFAULT_TYPE="all"

declare -A OPTIONS

declare -A ACTIONS
ACTIONS["commit"]="Commit changes to host and/or user config"

declare -A TYPES
TYPES["key"]="Process all SSH and AGE key"
TYPES["config"]="Process all config"
TYPES["secret"]="Process all secrets"
TYPES["all"]="Process all secrets, config and keys"

LOG_FILE="${SCRIPTPATH}/git.sh.log"

_has_git_diff() {
  for path in $commit_path; do
    if [[ $(git diff -- "${path}" | wc -l) -gt 0 ]]; then
      return
    fi
  done
  return 1
}

_git_commit() {
  for path in ${commit_path}; do
    {
      echo "pre-commit run --files \"${path}\""
      pre-commit run --files "${path}"
      git add -N "${path}"
      git add "${path}"
    } &>>"${LOG_FILE}"
  done
  if ! git commit -m "${msg}" &>>"${LOG_FILE}"; then
    # git restore --staged "$(git rev-parse --show-toplevel)"
    return 1
  fi
}

_commit() {
  local lvl=${1} # HM or OS

  if _has_git_diff; then
    _log "INFO" "Commit ${lvl} ${type} **${host}:${user}**"
    local msg="${gitmoji}(${host}): Update ${lvl} ${type} ${host}:${user}"

    if ! _git_commit; then
      _log "ERROR" "An error occured with commit of **${host}:${user}**"
      exit 1
    fi
  else
    _log "DEBUG" "Nothig to commit for ${action} **${host}:${user}**"
    _log "DEBUG" "${commit_path}"
  fi
}

_commit_secret() {
  local gitmoji="🔐"
  local commit_path="${MACHINE_PATH}/"

  if [[ -n "${host}" ]] && [[ -z "${user}" ]]; then
    commit_path+="${host}/*.enc.*"
    _commit "OS"
  elif [[ -n "${host}" ]] && [[ -n "${user}" ]]; then
    commit_path+="${host}/${user}/*.enc.*"
    _commit "HM"
  fi
}

_commit_key() {
  local gitmoji="🔐"
  local commit_path

  if [[ -n "${host}" ]] && [[ -z "${user}" ]]; then
    commit_path="${MACHINE_PATH}/${host}/keys/age.enc.txt"
    _commit "OS AGE"
    commit_path="${MACHINE_PATH}/${host}/keys/ssh_host_*"
    _commit "OS SSH"
  elif [[ -n "${host}" ]] && [[ -n "${user}" ]]; then
    commit_path="${MACHINE_PATH}/${host}/${user}/keys/age.enc.txt"
    _commit "HM AGE"
    commit_path="${MACHINE_PATH}/${host}/${user}/keys/${user}-${host}*"
    _commit "HM SSH"
  fi
}

_commit_config() {
  local commit_path="${MACHINE_PATH}/"
  local gitmoji="🔧"

  if [[ -n "${host}" ]] && [[ -z "${user}" ]]; then
    commit_path+="${host}/*.nix"
    _commit "OS"
  elif [[ -n "${host}" ]] && [[ -n "${user}" ]]; then
    commit_path+="${host}/${user}/*.nix"
    _commit "HM"
  fi
}

_process() {
  local host=$1
  local user=$2

  "_${action}_${type}"
}

_process_user() {
  if [[ "${type}" == "all" ]]; then
    for type in "key" "secret" "config"; do
      _process "${host}" "${user}"
    done
    type="all"
  else
    _process "${host}" "${user}"
  fi
}

commit_user() {
  _process_user
}

_process_host() {
  if [[ "${type}" == "all" ]]; then
    for type in "key" "secret" "config"; do
      _process "${host}"
    done
    type="all"
  else
    _process "${host}"
  fi
}

commit_host() {
  _process_host
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  parse_args "$@"
  shift $((OPTIND - 1))

  local secret_regexp
  local secret_files
  # shellcheck disable=SC2016
  secret_regexp=$(
    yq \
      '.creation_rules.[] as $item ireduce ([]; . += ($item.path_regex | sub("\\\/","/"))) | join("|")' \
      "${REPO_DIR}/.sops.yaml"
  )
  secret_files=$(find "${REPO_DIR}" -type f -print | grep -E "${secret_regexp}")

  local action="${1}"
  if [[ -n "${action}" ]]; then
    shift
  fi
  action=$(check_option_valid "action" "${action}" "ACTIONS")

  local host=${1}
  if [[ -n ${host} ]]; then
    shift
  fi
  check_host "${DEFAULT_HOST}"

  local user=${1}
  if [[ -n ${user} ]]; then
    shift
  fi
  check_user "${DEFAULT_HOST}"

  local type=${1}
  if [[ -n ${type} ]]; then
    shift
  fi
  type=$(check_option_valid "type" "${type}" "TYPES" "${DEFAULT_TYPE}")

  process_hosts
}

main "$@"
