#!/usr/bin/env bash
set -e

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

ACTIONS_DICT=(
  "config"
  "key"
  "secret"
)

ACTIONS="(${ACTIONS_DICT[*]/%/\|}all)"
ACTIONS="${ACTIONS// /}"

source "$(git rev-parse --show-toplevel)/scripts/_init_logger.sh"

usage() {
  _log "INFO" "Usage: ./commit ${ACTIONS} (HOSTNAME|all) [USERNAME|all] [HOST_DIR]"
}

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
    pre-commit run --files "${path}" &>>"${log_file}"
    git add "${path}" &>>"${log_file}"
  done
  if ! git commit -m "${msg}" &>>"${log_file}"; then
    # git restore --staged "$(git rev-parse --show-toplevel)"
    return 1
  fi
}

_commit() {
  if _has_git_diff; then
    _log "INFO" "Commit ${action} **${host}${user}**"

    local lvl=${1} # HM or OS
    local msg="${gitmoji}(cfg/host/${host}): Update ${lvl} ${host}${user} ${action}"

    echo "INFO Commit ${action} **${host}${user}**" >>"${log_file}"
    if ! _git_commit; then
      _log "ERROR" "An error occured with commit of **${host}${user}**"
      _log "ERROR" "See ./${log_file/"${PWD}/"/} for more details"
    fi
  else
    _log "DEBUG" "Nothig to commit for ${action} **${host}${user}**"
    _log "DEBUG" "${commit_path}"
  fi
}

commit_secret() {
  local gitmoji="🔐"
  local commit_path="${abs_path}/*.enc.*"

  if [[ -n "${host}" ]] && [[ -z "${user}" ]]; then
    _commit "OS"
  elif [[ -n "${host}" ]] && [[ -n "${user}" ]]; then
    _commit "HM"
  fi
}

commit_key() {
  local gitmoji="🔐"
  local commit_path

  if [[ -n "${host}" ]] && [[ -z "${user}" ]]; then
    commit_path="${abs_path}/age.enc.txt ${abs_path}/ssh_host_*"
    _commit "OS age & ssh"
  elif [[ -n "${host}" ]] && [[ -n "${user}" ]]; then
    commit_path="${abs_path}/age.enc.txt ${abs_path}/${arg_user}-${host}*"
    _commit "HM age & ssh"
  fi
}

commit_config() {
  local commit_path="${abs_path}/*.nix"
  local gitmoji="🔧"

  if [[ -n "${host}" ]] && [[ -z "${user}" ]]; then
    _commit "OS"
  elif [[ -n "${host}" ]] && [[ -n "${user}" ]]; then
    _commit "HM"
  fi
}

commit_all() {
  for action in "${ACTIONS_DICT[@]}"; do
    "commit_${action}"
  done
  action="all"
}

process_user() {
  local user=${arg_user/[a-z]/:&}
  _log "DEBUG" "Process update_user for **${host}${user}**"

  "commit_${action}"
}

process_users() {
  local old_arg_user="${arg_user}"

  if [[ "${arg_user}" == "none" ]]; then
    return
  elif [[ "${arg_user}" == "all" ]]; then
    for user in "${abs_path}"/*; do
      if [[ -d "${user}" ]]; then
        abs_path=${user}
        arg_user=$(basename "${user}")
        process_user
      fi
    done
  else
    abs_path+="/${arg_user}"
    process_user
  fi

  arg_user="${old_arg_user}"
}

process_host() {
  local abs_path="${abs_path}"
  local user
  _log "DEBUG" "Process update_host for **${host}${user}**"

  process_users

  abs_path=$(dirname "${abs_path}")
  user=""
  "commit_${action}"
}

process_hosts() {
  if [[ -z "${arg_host}" ]] || [[ "${arg_host}" == "all" ]]; then
    for host in "${abs_path}"/*; do
      if [[ -d "${host}" ]]; then
        abs_path="${host}"
        host=$(basename "${host}")
        arg_user=${arg_user:-"all"}
        process_host
      fi
    done
  else
    host="${arg_host}"
    abs_path+="/${arg_host_dir:-"${arg_host}"}"
    arg_user=${arg_user:-"all"}
    process_host
  fi
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  init_logger

  local repo_dir
  local host
  local user

  while getopts "h" opt; do
    _log "WARNING" "Process args : ${opt}"
    case ${opt} in
    h)
      usage
      exit 0
      ;;
    *)
      _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
      exit 1
      ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ $# -eq 0 ]]; then
    usage
    exit 1
  fi

  repo_dir=$(git rev-parse --show-toplevel)
  abs_path="${repo_dir}/configs/hosts"

  action=${1}
  arg_host=${2}
  arg_user=${3}
  arg_host_dir=${4}

  if ! [[ "${action}" =~ ^${ACTIONS}$ ]]; then
    _log "ERROR" "Please specify action, either \`config\`, \`key\` or \`all\`"
    usage
    exit 1
  elif [[ -z "${arg_host}" ]] && [[ "${action}" != "all" ]]; then
    _log "ERROR" "Please specify HOSTNAME or 'all'"
    usage
    exit 1
  fi

  local log_file="${SCRIPTPATH}/commit.log"
  cat <<EOM >>"${log_file}"
=========================================================
$(date) - Running ${SCRIPTPATH}/$0
---------------------------------------------------------

EOM

  process_hosts
}

main "$@"
