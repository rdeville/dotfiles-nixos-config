#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wrapper to manage my private key

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
ACTIONS["generate"]="Generate specified private keys"
ACTIONS["verify"]="Verify specified keys"
ACTIONS["rotate"]="Rotate specified keys"

declare -A ALGOS
ALGOS["all"]="Process all SSH and AGE key"
ALGOS["ssh"]="Process ed25519 SSH key type"
ALGOS["age"]="Process AGE key type"

_return() {
  if [[ -f "${tmp}" ]]; then
    rm "${tmp}"
  fi
}

_generate_kp_entry() {
  local password_options

  if [[ -n "${user}" ]]; then
    password_options="-g -L 128 -l -U -n -s --exclude-similar "
  fi

  if kp show "${kp_entry}" 2>&1 | grep -q -E "Output of .* is empty"; then
    _log "INFO" "Edit Keepass entry **${host}${username}** ${algo^^} ${type}."
    kp edit "${password_options}" "${kp_entry}" &>/dev/null
  else
    _log "INFO" "Create Keepass entry **${host}${username}** ${algo^^} ${type}."
    kp mkdir "$(dirname "${kp_entry}")" &>/dev/null
    kp add "${password_options}" "${kp_entry}" &>/dev/null
  fi
}

_kp_add_attachments() {
  local filepath="$1"
  local filename="${2:-"${filepath}"}"

  filename="$(basename "${filepath}")"

  if ! kp attachment-export "${kp_entry}" "${filename}" "${tmp}" &>/dev/null; then
    kp attachment-import "${kp_entry}" "${filename}" "${filepath}" &>/dev/null
  elif "${diff}" "${tmp}" "${filepath}" &>/dev/null; then
    local datePrefix
    datePrefix="$(date '+%Y-%m-%d-%H:%M')"

    _log "INFO" "Rotating **${host}${username} stored key since it differs with local one"
    kp attachment-import "${kp_entry}" "${datePrefix}-${filename}" "${tmp}" &>/dev/null
    kp attachment-import "${kp_entry}" "${filename}" "${filepath}" &>/dev/null
  else
    _log "WARNING" "File for key **${host}${username} already stored"
  fi
}

# Check keys functions
# -----------------------------------------------------------------------------
_verify_age() {
  if ! kp show "${kp_entry}" -a "Title" &>/dev/null; then
    _log "ERROR" "No Key entry for **${host}${username}** ${algo^^}"
    return 1
  elif ! kp attachment-export "${kp_entry}" "${filename}" "${tmp}" &>/dev/null; then
    _log "ERROR" "No Key file **${host}${username}** ${algo^^} should be stored in key entry"
    return 1
  elif ! [[ -f "${filepath}" ]]; then
    _log "ERROR" "Key for **${host}${username}** ${algo^^} is stored but file does not exists"
    return 1
  else
    local tmpDecrypted

    tmpDecrypted=$(mktemp)
    sops -d "${encfile}" >"${tmpDecrypted}"

    if "${diff}" "${encfile}" "${tmp}" &>/dev/null; then
      _log "ERROR" "Key file for **${host}${username}** ${algo^^} differs from the one stored"
      rm "${tmpDecrypted}"
      return 1
    fi

    rm "${tmpDecrypted}"
  fi

  _log "INFO" "Key file and stored ones correspond for **${host}${username}** ${algo^^} ${type}"
}

_verify_ssh() {
  if [[ -n "${user}" ]]; then
    if [[ -f "${filepath}" ]]; then
      _log "ERROR" "Key **${host}${username}** ${algo^^} should not exists"
      return 1
    elif ! kp attachment-export "${kp_entry}" "${filename}" "${tmp}" &>/dev/null; then
      _log "ERROR" "Key **${host}${username}** ${algo^^} should be stored"
      return 1
    elif ! kp show "${kp_entry}" -a "Password" &>/dev/null; then
      _log "ERROR" "Key stored for **${host}${username}** ${algo^^} does not have password"
      return 1
    else
      chmod 0600 "${tmp}"
      ssh-keygen -y -f "${tmp}" \
        -P "$(kp show "${kp_entry}" -a "Password" 2>/dev/null)" >"${tmp}.pub"

      if ! [[ -f "${filepath}.pub" ]]; then
        _log "ERROR" "Public key file **${host}${username}** ${algo^^} is absent"
        return 1
      fi

      if ${diff} "${filepath}.pub" "${tmp}.pub" &>/dev/null; then
        _log "ERROR" "Public key file **${host}${username}** ${algo^^} differs from the public key generated from the stored one"
        rm "${tmp}.pub"
        return 1
      fi
    fi
  else
    if ! kp show "${kp_entry}" -a "Title" &>/dev/null; then
      _log "ERROR" "No Key entry for **${host}${username}** ${algo^^}"
      return 1
    elif ! kp attachment-export "${kp_entry}" "${filename}" "${tmp}" &>/dev/null; then
      _log "ERROR" "No Key file **${host}${username}** ${algo^^} should be stored in key entry"
      return 1
    elif ! [[ -f "${encfile}" ]]; then
      _log "ERROR" "Key for **${host}${username}** ${algo^^} is stored but file does not exists"
      return 1
    else
      local tmpDecrypted

      # Check private key
      tmpDecrypted=$(mktemp)
      sops -d "${encfile}" >"${tmpDecrypted}"

      if "${diff}" "${encfile}" "${tmp}" &>/dev/null; then
        _log "ERROR" "Key file for **${host}${username}** ${algo^^} differs from the one stored"
        rm "${tmpDecrypted}"
        return 1
      fi

      rm "${tmpDecrypted}"

      # Check public key
      chmod 0600 "${tmp}"
      ssh-keygen -y -f "${tmp}" \
        -P "$(kp show "${kp_entry}" -a "Password" 2>/dev/null)" >"${tmp}.pub"

      if ${diff} "${filepath}.pub" "${tmp}.pub" &>/dev/null; then
        _log "ERROR" "Public key file **${host}${username}** ${algo^^} differs from the public key generated from the stored one"
        rm "${tmp}.pub"
        return 1
      fi
    fi
  fi

  _log "INFO" "Key file and stored ones correspond for **${host}${username}** ${algo^^} ${type}"
}

_verify_key() {
  _log "INFO" "Checking state of key **${host}${username}** ${algo^^}"

  case "${algo}" in
  age)
    _verify_age
    ;;
  ssh)
    _verify_ssh
    ;;
  esac
}

# Rotate keys functions
# -----------------------------------------------------------------------------
_rotate_key() {
  echo _rotate_key TODO
}

# Generate keys functions
# -----------------------------------------------------------------------------
_generate_age() {
  if _verify_age &>/dev/null; then
    _log "WARNING" "Key file and stored ones correspond for **${host}${username}** ${algo^^} ${type}"
    return
  fi

  if [[ -f "${filepath}" ]]; then
    _log "ERROR" "Private Key **${host}${username}** ${algo^^} ${type} exists but shouldn't"
    _log "ERROR" "Nothing will be done still file exists"
    return 1
  fi

  age-keygen -o "${filepath}" &>/dev/null

  if ! kp show "${kp_entry}" -a "Title" &>/dev/null; then
    _generate_kp_entry
  fi

  _log "INFO" "Attach files to Keepass entry **${host}${username}** ${algo^^} ${type}"
  _kp_add_attachments "${filepath}" "${filepath}.age"

  encrypt "${encfile}"
  chmod 0600 "${encfile}"
}

_generate_ssh() {
  if _verify_ssh &>/dev/null; then
    _log "WARNING" "Key file and stored ones correspond for **${host}${username}** ${algo^^} ${type}"
    return
  fi

  if ! kp show "${kp_entry}" -a "Title" &>/dev/null; then
    _generate_kp_entry
  fi

  ssh-keygen -q -C "${comment}" -t "${type}" -b 4096 -f "${filepath}" \
    -P "$(kp show "${kp_entry}" -a "Password" 2>/dev/null)"

  _log "INFO" "Attach files to Keepass entry **${host}:${user}** ${algo^^} ${type}."
  _kp_add_attachments "${filepath}" "${filepath}.asc"
  _kp_add_attachments "${filepath}.pub" "${filepath}.pub"

  if [[ -n "${user}" ]]; then
    rm "${filepath}"
  else
    mv "${filepath}" "${encfile}"
    encrypt "${encfile}"
  fi
  rm "${tmp}"
  chmod 0600 "${filepath}.pub"

  _verify_ssh
}

_generate_key() {
  local comment

  if ! [[ -d "$(dirname "${filepath}")" ]]; then
    mkdir -p "$(dirname "${filepath}")"
  fi

  if [[ -n "${user}" && -f "${filepath}" && "${algo}" == "ssh" ]]; then
    _log "ERROR" "Private Key **${host}${username}** ${algo^^} ${type} exists but shouldn't"
    _log "ERROR" "Nothing will be done still file exists"
    rm "${tmp}"
    return 1
  fi

  case "${algo}" in
    age)
      _generate_age
      ;;
    ssh)
      _generate_ssh
      ;;
  esac

  rm "${tmp}"
}

# Key management related method
# -----------------------------------------------------------------------------
_compute_key_path() {
  case ${algo} in
  age)
    filepath="${path}/age.enc.txt"
    encfile="${filepath}"
    ;;
  ssh)
    # shellcheck disable=SC2154
    if [[ -n "${user}" ]]; then
      filepath=${path}/${user}-${host}
      type="ed25519"
    else
      filepath=${path}/${host}-${type}
    fi
    encfile="${filepath}.enc.asc"
    ;;
  *)
    _log "ERROR" "Wrong algo for the private key type: algo=${algo}"

    return 1
    ;;
  esac
}

_compute_kp_entry() {
  if [[ -z "${user}" ]]; then
    if [[ "${type}" == "age" ]]; then
      kp_entry="${kp_prefix}/${algo}-key@${host}"
    else
      kp_entry="${kp_prefix}/${algo}-${type}@${host}"
      comment="${host}"
    fi
  else
    kp_entry="${kp_prefix}/${algo}-${user}@${host}"
    comment="${user}@${host}"
  fi
}

# Process functions
# -----------------------------------------------------------------------------
_process_key() {
  local filepath
  local filename
  local encfile
  local kp_entry
  local tmp

  tmp=$(mktemp)
  chmod 0600 "${tmp}"

  _compute_kp_entry
  _compute_key_path

  filename=$(basename "${filepath}")

  "_${action}_key"
}

_process_user() {
  local path="${MACHINE_PATH}/${host}/${user}/_keys"
  local kp_prefix="/ordinateur/${host}"
  local username=":${user}"

  if [[ "${algo}" == "all" ]]; then
    algo="age"
    type="age"
    _process_key

    algo="ssh"
    type="ed25519"
    _process_key

    algo="all"
  else
    _process_key
  fi
}

rotate_user() {
  _process_user
}

generate_user() {
  _process_user
}

verify_user() {
  _process_user
}

_process_host() {
  local path="${MACHINE_PATH}/${host}/_keys"
  local kp_prefix="/ordinateur/${host}"

  if [[ "${algo}" == "all" ]]; then
    algo="age"
    type="age"
    _process_key

    algo="ssh"
    type="ed25519"
    _process_key

    algo="ssh"
    type="rsa"
    _process_key

    type="all"
  else
    case "${algo}" in
    age)
      type="age"
      _process_key
      ;;
    ssh)
      type="rsa"
      _process_key

      type="ed25519"
      _process_key
      ;;
    esac
  fi
}

rotate_host() {
  _process_host
}

generate_host() {
  _process_host
}

verify_host() {
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
  check_user "${DEFAULT_USER}"

  local algo=${1}
  if [[ -n ${algo} ]]; then
    shift
  fi
  algo=$(check_option_valid "algo" "${algo}" "ALGOS" "${DEFAULT_ALGO}")


  local diff="diff"
  if command -v delta &>/dev/null; then
    diff="delta"
  fi

  local cmd=""
  process_hosts
}

main "$@"
