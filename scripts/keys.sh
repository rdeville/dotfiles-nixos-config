#!/usr/bin/env bash
set -e

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

source "$(git rev-parse --show-toplevel)/scripts/_init_logger.sh"

update_user() {
  if [[ $# -ne 2 ]]; then
    _log "INFO" "Usage: ./generate_ssh user HOST_DIR USERNAME"
    exit 1
  fi

  path="configs/hosts/${1}/${2}/age.enc.txt"
  dir="$(dirname "${path}")"

  _log "INFO" "Update private key for ${dir}"
  mkdir -p "${dir}"
  if ! [[ -f "${path}" ]]; then
    _log "INFO" "Generating user $2 AGE private key"
    age-keygen -o "${path}"
  fi

  if ${install}; then
    filename=$(basename "${path}")
    dest="${HOME}/.cache/.${filename/".enc.txt"/}.key"
    if ! [[ -f "${dest}" ]]; then
      echo cp "${path}" "${dest}"
    else
      _log "WARNING" "Dest file **${dest}** already exists. Nothing will be done."
    fi
  fi
}

update_host() {
  if [[ $# -ne 2 ]]; then
    _log "INFO" "Usage: ./generate_ssh host HOST_DIR HOSTNAME"
    exit 1
  fi

  path="${repo_dir}/configs/hosts/${1}"
  hostname="$2"
  dir="$(dirname "${path}")"
  user="root"

  _log "INFO" "Update private key for ${path}"
  mkdir -p "${path}"

  rsa="${path}/ssh_host_rsa_key"
  ssh-keygen -q -C "${user}@${hostname}" -N "" -t rsa -b 4096 -f "${rsa}"
  mv "${rsa}" "${rsa}.enc.asc"
  mv "${rsa}.pub" "${rsa}.pub.enc.asc"

  ed25519=${path}/ssh_host_ed25519_key
  ssh-keygen -q -C "${user}@${hostname}" -N "" -t ed25519 -f "${ed25519}"
  mv "${ed25519}" "${ed25519}.enc.asc"
  mv "${ed25519}.pub" "${ed25519}.pub.enc.asc"

  if ${install}; then
    for src in "${path}/"ssh_host_*; do
      filename=$(basename "${src}")
      dest="/etc/ssh/${filename/".enc.asc"/}"
      if ! [[ -f "${dest}" ]]; then
        echo sudo cp "${src}" "/etc/sshd/${filename/".enc.asc"/}"
      else
        _log "WARNING" "Dest file **${dest}** already exists. Nothing will be done."
      fi
    done
  fi
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  init_logger

  local repo_dir
  local install=false

  repo_dir=$(git rev-parse --show-toplevel)

  while getopts "i" opt; do
    _log "DEBUG" "Process args : ${opt}"
    case ${opt} in
    i) # verbosity
      install=true
      ;;
    *)
      _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
      exit 1
      ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ $# -lt 2 ]]; then
    _log "INFO" "Usage: ./generate_ssh (host|user)"
    exit 1
  fi

  if [[ "$1" == "user" ]]; then
    shift
    update_user "$@"
  fi

  if [[ "$1" == "host" ]]; then
    shift
    update_host "$@"
  fi
}

main "$@"
