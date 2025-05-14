#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wrapper to manage my private key
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

_generate_kp_entry() {
  if kp show "${kp_entry}" 2>&1 | grep -q -E "Output of .* is empty"; then
    _log "INFO" "Edit Keepass entry **${host}:${user}** ${algo^^} ${type}."
    kp edit -g -L 128 -l -U -n -s --exclude-similar "${kp_entry}" &>/dev/null
  else
    _log "INFO" "Create Keepass entry **${host}:${user}** ${algo^^} ${type}."
    kp add -g -L 128 -l -U -n -s --exclude-similar "${kp_entry}" &>/dev/null
  fi
}

_kp_add_attachments() {
  local filepath="$1"
  local filename

  filename="$(basename "${filepath}")"

  if kp attachment-export "${kp_entry}" "${filename}" "${filepath}" &>/dev/null; then
    local datePrefix
    datePrefix="$(date '+%Y-%m-%d-%H:%M')"
    kp attachment-import "${kp_entry}" "${datePrefix}-${filename}" "${filepath}" &>/dev/null
  fi

  kp attachment-import "${kp_entry}" "${filename}" "${filepath}" &>/dev/null
}

_generate_age() {
  if [[ -f ${filepath} ]]; then
    # shellcheck disable=SC2154
    _log "WARNING" "Key **${host}${username}** ${algo^^} ${type} already exists."
    return
  fi

  if [[ -z "${user}" ]]; then
    kp_entry="${kp_prefix}/age-key@host"
  else
    kp_entry="${kp_prefix}/age-${user}@${host}"
  fi

  if ! kp show "${kp_entry}" -a "Title" &>/dev/null; then
    _generate_kp_entry
    _log "INFO" "Backup Generating **${host}${username}** ${algo^^} private key."
    mv "${filepath}" "${filepath}.bak"
  fi

  if [[ -n "${user}" ]]; then
    comment="${user}@${host}"
  fi

  if ! [[ -f ${filepath} ]]; then
    age-keygen -o "${filepath}" &>/dev/null
  fi

  _log "INFO" "Attach files to Keepass entry **${host}:${user}** ${algo^^} ${type}."
  _kp_add_attachments "${filepath}"

  if ! [[ -f "${encfile}" ]]; then
    mv "${filepath}" "${encfile}"
    encrypt "${encfile}"
    chmod 0600 "${encfile}"
  fi

  _log "INFO" "Generating **${host}${username}** ${algo^^} private key"
  age-keygen -o "${filepath}" &>/dev/null
  encrypt "${encfile}"
  chmod 0600 "${encfile}"
}

_generate_ssh() {
  local comment="${host}"
  local kp_passgen_options=" -L 128 -l -U -n -s --exclude-similar"
  local kp_entry

  if [[ -f ${filepath} ]]; then
    _log "WARNING" "Key **${host}${username}** ${algo^^} ${type} already exists."
    return
  fi

  if [[ -z "${user}" ]]; then
    kp_entry="${kp_prefix}/$(basename "${filepath//_key/}")@host"
  else
    kp_entry="${kp_prefix}/ssh-${user}@${host}"
  fi

  if ! kp show "${kp_entry}" -a "Password" &>/dev/null; then
    _generate_kp_entry
    _log "INFO" "Backup Generating **${host}${username}** ${algo^^} ${type} private key."
    mv "${filepath}" "${filepath}.bak"
  fi

  if [[ -n "${user}" ]]; then
    comment="${user}@${host}"
  fi

  ssh-keygen -q -C "${comment}" -t "${type}" -b 4096 -f "${filepath}" \
    -P "$(kp show "${kp_entry}" -a "Password")"

  _log "INFO" "Attach files to Keepass entry **${host}:${user}** ${algo^^} ${type}."
  _kp_add_attachments "${filepath}"
  _kp_add_attachments "${filepath}.pub"

  if ! [[ -f "${encfile}" ]]; then
    mv "${filepath}" "${encfile}"
    encrypt "${encfile}"
    chmod 0600 "${encfile}"
    chmod 0600 "${filepath}.pub"
  fi
}

_rotate_key() {
  _log "INFO" "Backup ${encfile//"${MACHINE_PATH}/"/}"
  mv "${encfile}" "${encfile}.bak"
  mv "${filepath}" "${filepath}.bak"

  case ${algo} in
  age)
    _generate_age
    ;;
  ssh)
    _generate_ssh
    ;;
  esac
}

_generate_key() {
  if _key_exists; then
    _log "WARNING" "Key **${host}${username}** ${algo^^} ${type} already exists."
    return
  fi

  case ${algo} in
  age)
    _generate_age
    ;;
  ssh)
    _generate_ssh
    ;;
  esac
}

# Key management related method
_compute_key_path() {
  local path=$1
  local user=$2

  case ${type} in
  age)
    filepath="${path}/age.enc.txt"
    encfile="${filepath}"
    algo="age"
    ;;
  user)
    type="ed25519"
    # shellcheck disable=SC2154
    filepath=${path}/${user}-${host}
    encfile="${filepath}.enc.asc"
    algo="ssh"
    ;;
  rsa)
    filepath="${path}/ssh_host_rsa_key"
    encfile="${filepath}.enc.asc"
    algo="ssh"
    ;;
  ed25519)
    filepath=${path}/ssh_host_ed25519_key
    encfile="${filepath}.enc.asc"
    # shellcheck disable=SC2034
    algo="ssh"
    ;;
  *)
    _log "ERROR" "Wrong type for the private key type: type=${type}"
    return 1
    ;;
  esac
}

_process_key() {
  local host=$1
  local userName=$2
  local filepath
  local encfile
  local algo

  _compute_key_path "${path}" "${userName}"
  "_${action}_key"
}

_process_user() {
  local path="${MACHINE_PATH}/${host}/${user}/_keys"

  if [[ "${type}" == "all" ]]; then
    for type in "age" "user"; do
      _process_key "${host}" "${user}"
    done
    type="all"
  else
    _process_key "${host}" "${user}"
  fi
}

rotate_user() {
  _process_user
}

generate_user() {
  _process_user
}

_process_host() {
  local path="${MACHINE_PATH}/${host}/_keys"
  local kp_prefix="/ordinateur/${host}"

  if [[ "${type}" == "all" ]]; then
    for type in "age" "rsa" "ed25519"; do
      _process_key "${host}"
    done
    type="all"
  else
    _process_key "${host}"
  fi
}

rotate_host() {
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
