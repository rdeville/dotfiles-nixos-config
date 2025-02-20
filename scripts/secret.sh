#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wraper to manage secrets encryptions

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="secret"
DESC="Wrapper to ease managing secrets for host and/or user"
LEVEL="type"
DEFAULT_HOST="all"
DEFAULT_USER="all"
DEFAULT_TYPE="all"

declare -A OPTIONS

declare -A ACTIONS
ACTIONS["decrypt"]="Decrypt secrets"
ACTIONS["encrypt"]="Encrypt secrets"
ACTIONS["reencrypt"]="Decrypt and reencrypt private keys"

declare -A TYPES
TYPES["key"]="Process all SSH and AGE key"
TYPES["secret"]="Process all SSH key type (rsa and ed25519)"
TYPES["all"]="Process all secrets and key"

_encrypt_key() {
  encrypt "${encfile}"
}

_encrypt_secret() {
  encrypt "${encfile}"
}

_decrypt_key() {
  decrypt "${encfile}"
}

_decrypt_secret() {
  decrypt "${encfile}"
}

_reencrypt_key() {
  reencrypt "${encfile}"
}

_reencrypt_secret() {
  reencrypt "${encfile}"
}

_process() {
  local host=$1
  local user=$2
  local encfiles
  local regexp="${host}/"

  if [[ -n "${user}" ]]; then
    regexp+="${user}/"
  fi

  if [[ "${type}" == "all" ]]; then
    return
  fi

  case "${type}" in
  key)
    regexp+="${type}.*\.enc\.(asc|txt)$"
    ;;
  secret)
    regexp+=".*\.enc\.(yaml|json)$"
    ;;
  esac

  while IFS= read -r encfile; do
    if [[ -n "${encfile}" ]] && [[ -f "${encfile}" ]]; then
      "_${action}_${type}"
    fi
  done <<<"$(find "${REPO_DIR}" -type f -print | grep -E "${regexp}")"
}

_process_user() {
  if [[ "${type}" == "all" ]]; then
    for type in "${!TYPES[@]}"; do
      _process "${host}" "${user}"
    done
    type="all"
  else
    _process "${host}" "${user}"
  fi
}

reencrypt_user() {
  _process_user
}

decrypt_user() {
  _process_user
}

encrypt_user() {
  _process_user
}

_process_host() {
  if [[ "${type}" == "all" ]]; then
    for type in "${!TYPES[@]}"; do
      _process "${host}"
    done
    type="all"
  else
    _process "${host}"
  fi
}

reencrypt_host() {
  _process_host
}

decrypt_host() {
  _process_host
}

encrypt_host() {
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
  action=$(check_option_valid "action" "${action}" "ACTIONS" "")

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
