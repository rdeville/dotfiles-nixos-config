#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wraper to manage my private key
#
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="key"
DESC="Wrapper to ease management of host and user encryption and ssh keys"
LEVEL="type"
DEFAULT_HOST="all"
DEFAULT_USER="all"
DEFAULT_TYPE="all"

declare -A OPTIONS

CONTEXT_OPTIONS=$(
  options="${!OPTIONS[*]}"
  echo "h${options// /}"
)

declare -A ACTIONS
ACTIONS["generate"]="Generate missing private keys"
ACTIONS["reencrypt"]="Decrypt and reencrypt private keys"
ACTIONS["rotate"]="Rotate private keys"

declare -A TYPES
TYPES["all"]="Process all SSH and AGE key"
TYPES["ssh"]="Process all SSH key type (rsa and ed25519)"
TYPES["rsa"]="Process rsa SSH key type"
TYPES["ed25519"]="Process ed25519 SSH key type"
TYPES["user"]="Process user SSH key type"
TYPES["age"]="Process AGE key type"

_key_exists() {
  if test -f "${encfile}"; then
    return 0
  fi

  if ! [[ -d "${path}" ]]; then
    _log "DEBUG" "Creating dir **${path//"${REPO_DIR}/"/}**"
    mkdir -p "${path}"
  fi

  return 1
}

_reencrypt_key() {
  if ! _key_exists; then
    _log "INFO" "Key file **${encfile//"${MACHINE_PATH}/"/}** does not exists."
    return
  fi

  _log "INFO" "Backup ${encfile//"${MACHINE_PATH}/"/}"
  cp "${encfile}" "${encfile}.bak"

  reencrypt "${encfile}"
}

_rotate_key() {
  if ! _key_exists; then
    _log "INFO" "Key file **${encfile//"${MACHINE_PATH}/"/}** does not exists."
    return
  fi

  _log "INFO" "Backup ${encfile//"${MACHINE_PATH}/"/}"
  mv "${encfile}" "${encfile}.bak"

  case ${algo} in
    age)
      _log "INFO" "Generating **${host}${user//*/:&}** ${algo^^} private key"
      age-keygen -o "${filepath}" &>/dev/null
      chmod 0600 "${encfile}"
      encrypt "${encfile}"
      ;;
    ssh)
      mv "${filepath}.pub" "${filepath}.pub.bak"

      _log "INFO" "Generating **${host}${user//*/:&}** ${algo^^} private key"
      ssh-keygen -q -C "${user}@${host}" -N "" -t "${type}" -b 4096 -f "${filepath}"
      mv "${filepath}" "${encfile}"
      chmod 0600 "${encfile}"
      encrypt "${encfile}"
      ;;
  esac
}

_generate_key() {
  if _key_exists; then
    _log "INFO" "Key file **${encfile//"${MACHINE_PATH}/"/}** already exists."
    return
  fi

  case ${algo} in
    age)
      _log "INFO" "Generating **${host}${user//*/:&}** ${algo^^} private key"
      age-keygen -o "${filepath}" &>/dev/null
      encrypt "${encfile}"
      chmod 0600 "${encfile}"
      ;;
    ssh)
      _log "INFO" "Generating **${host}${user//*/:&}** ${algo^^} private key"
      ssh-keygen -q -C "${user}@${host}" -N "" -t "${type}" -b 4096 -f "${filepath}"
      mv "${filepath}" "${encfile}"
      encrypt "${encfile}"
      chmod 0600 "${encfile}"
      ;;
  esac
}

_process_key() {
  local host=$1
  local user=$2
  local filepath
  local encfile
  local algo

  compute_key_path "${path}"
  "_${action}_key"
}

_process_user() {
  local path="${MACHINE_PATH}/${host}/${user}/keys"

  if [[ "${type}" == "all" ]]; then
    for type in "age" "user"; do
      _process_key "${host}" "${user}"
    done
    type="all"
  else
    _process_key "${host}" "${user}"
  fi
}

rotate_user(){
  _process_user
}

reencrypt_user() {
  _process_user
}

generate_user() {
  _process_user
}

_process_host() {
  local path="${MACHINE_PATH}/${host}/keys"

  if [[ "${type}" == "all" ]]; then
    for type in "age" "rsa" "ed25519"; do
      _process_key "${host}"
    done
    type="all"
  else
    _process_key "${host}"
  fi
}

rotate_host () {
  _process_host
}

reencrypt_host() {
  _process_host
}

generate_host() {
  _process_host
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  parse_args "$@"
  shift $((OPTIND - 1))

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

  local cmd=""
  process_hosts
}

main "$@"
