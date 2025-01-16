#!/usr/bin/env bash
set -e

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

source "$(git rev-parse --show-toplevel)/scripts/_init_logger.sh"

usage() {
  _log "INFO" "Usage: ./generate_ssh (deploy|update) (HOSTNAME|all) [USERNAME|all] [HOST_DIR]"
}

update_key() {
  if ! [[ -d "${abs_path}" ]]; then
    _log "INFO" "Creating dir **${repo_path}**"
    mkdir -p "${abs_path}"
  elif sudo test -f "${encfile}"; then
    _log "DEBUG" "Key file **${host}${user}/$(basename "${encfile}")** already exists."
    return
  fi

  if [[ ${algo} == "age" ]]; then
    _log "INFO" "Generating **${host}${user}** AGE private key"
    age-keygen -o "${filepath}" &>/dev/null
  elif [[ ${algo} == "ssh" ]]; then
    _log "INFO" "Generating **${host}${user}** SSH private key"
    ssh-keygen -q -C "${arg_user}@${host}" -N "" -t "${type}" -b 4096 -f "${filepath}"
    mv "${filepath}" "${filepath}.enc.asc"
  fi
}

exec_key_deployment() {
  eval "$cmd"

  if [[ -n "${user}" ]]; then
    eval "${cmd_start}chown ${user/:/}:users ${dest_file}${cmd_end}"
  fi

  eval "${cmd_start}chmod 0600 ${dest_file}${cmd_end}"
}

compute_key_deployment() {
  if [[ "${algo}" == "age" ]]; then
    dest_file="${dest_dir}/.age.key"
    if ! sudo test -f "${dest_file}"; then
      _log "INFO" "Installing **${host}${user}** AGE private key"
      cmd="${cmd_start}SOPS_AGE_KEY=${SOPS_AGE_KEY} sops -d \"${encfile}\" >\"${dest_file}\"${cmd_end}"
      exec_key_deployment
    else
      _log "WARNING" "**${host}${user}** AGE private key already exists"
    fi
  elif [[ "${algo}" == "ssh" ]]; then
    dest_file="${dest_dir}/$(basename "${filepath}")"
    if ! sudo test -f "${dest_file}"; then
      _log "INFO" "Installing **${host}${user}** SSH ${type} private key"
      cmd="${cmd_start}SOPS_AGE_KEY=${SOPS_AGE_KEY} sops -d \"${encfile}\" >\"${dest_file}\"${cmd_end}"
      exec_key_deployment
    else
      _log "WARNING" "**${host}${user}** SSH ${type} private key already exists"
    fi

    dest_file="${dest_dir}/$(basename "${filepath}").pub"
    if ! sudo test -f "${dest_file}"; then
      _log "INFO" "Installing **${host}${user}** SSH ${type} public key"
      cmd="${cmd_start}cp \"${filepath}.pub\" \"${dest_file}\"${cmd_end}"
      exec_key_deployment
    else
      _log "WARNING" "**${host}${user}** SSH ${type} public key already exists"
    fi
  fi
}

deploy_key() {
  local username=${user/:/}
  local cmd_start="sudo sh -c '"
  local cmd_end="'"

  if [[ -z "${user}" ]] && [[ "$(uname)" == "Darwin" ]]; then
    _log "WARNING" "Unable to install OS keys on Darwin systems"
    return
  elif [[ -z "${user}" ]]; then
    dest_dir="/etc/ssh"
  else
    if [[ "${username}" == "root" ]] && [[ "$(uname)" == "Darwin" ]]; then
      _log "WARNING" "Unable to install root user keys on Darwin systems"
      return
    elif [[ "${username}" == "root" ]]; then
      home="/${username}"
    elif [[ "$(uname)" == "Darwin" ]]; then
      home="/Users/${username}"
    else
      home="/home/${username}"
    fi

    if [[ "${algo}" == "age" ]]; then
      dest_dir="${home}/.cache"
    elif [[ "${algo}" == "ssh" ]]; then
      dest_dir="${home}/.ssh"
    fi
  fi

  compute_key_deployment
}

compute_key_path() {
  case ${type} in
  age)
    filepath="${abs_path}/age.enc.txt"
    encfile="${filepath}"
    algo="age"
    ;;
  user)
    type="ed25519"
    filepath=${abs_path}/${arg_user}-${host}
    encfile="${filepath}.enc.asc"
    algo="ssh"
    ;;
  rsa)
    filepath="${abs_path}/ssh_host_rsa_key"
    encfile="${filepath}.enc.asc"
    algo="ssh"
    ;;
  ed25519)
    filepath=${abs_path}/ssh_host_ed25519_key
    encfile="${filepath}.enc.asc"
    algo="ssh"
    ;;
  *)
    _log "ERROR" "Wrong type for the private key type."
    return 1
    ;;
  esac
}

process_key() {
  local type="$1"
  local filepath
  local algo

  compute_key_path
  "${action}_key" "${type}"
}

process_user() {
  local repo_path=${abs_path/"${repo_dir}/"/}
  local user=${arg_user/[a-z]/:&}
  _log "DEBUG" "Process update_user for **${host}${user}**"

  process_key "age"
  process_key "user"
}

process_users() {
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
}

process_host() {
  local repo_path=${abs_path/"${repo_dir}/"/}
  local abs_path="${abs_path}"
  local user
  _log "DEBUG" "Process update_host for **${host}${user}**"

  process_key "age"
  process_key "rsa"
  process_key "ed25519"
  process_users
}

process_hosts() {
  if [[ "${arg_host}" == "all" ]]; then
    if [[ "${action}" == "deploy" ]]; then
      host=$(hostname)
      abs_path="${abs_path}/${host}"
      arg_user="all"
      process_host
    else
      for host in "${abs_path}"/*; do
        if [[ -d "${host}" ]]; then
          abs_path="${host}"
          host=$(basename "${host}")
          arg_user="all"
          process_host
        fi
      done
    fi
  else
    host="${arg_host}"
    abs_path+="/${arg_host_dir:-"${arg_host}"}"
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
    _log "DEBUG" "Process args : ${opt}"
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

  if ! [[ "${action}" =~ ^(update|deploy)$ ]]; then
    _log "ERROR" "Please specify action, either \`update\` or \`deploy\`"
    usage
    exit 1
  elif [[ -z "${arg_host}" ]]; then
    _log "ERROR" "Please specify HOSTNAME or 'all'"
    usage
    exit 1
  fi

  process_hosts
}

main "$@"
