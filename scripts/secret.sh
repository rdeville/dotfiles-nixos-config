#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wrapper to manage secrets encryptions

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
  # shellcheck disable=SC2154
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

_check_common_to_reencrypt() {
  local path

  if [[ -n "${user}" ]]; then
    path="${REPO_DIR}/machines/${host}/${user}/*"
  else
    path="${REPO_DIR}/machines/${host}/_* ${REPO_DIR}/machines/${host}/*.nix"
  fi

  for common in "${REPO_DIR}"/common_secrets/*; do
    commonName="$(basename "${common}")"
    # shellcheck disable=SC2086
    # Space is needed below for host secrets
    if grep -q -r "${commonName}" ${path} &>/dev/null &&
      ! echo "${commonsToReencrypt[@]}" | grep -q "${commonName}"; then
      echo $host:$user:$commonName
      commonsToReencrypt+=("$commonName")
    fi
  done
}

_reencrypt_commons() {
  local _type="${type}"
  local regexp

  for common in "${commonsToReencrypt[@]}"; do
    regexp="common_secrets/${common}"

    if [[ "${_type}" == "all" ]]; then
      type="secret"
    fi

    if [[ "${type}" != "secret" ]]; then
      type="${_type}"
      return
    fi

    while IFS= read -r encfile; do
      if [[ -n "${encfile}" ]] && [[ -f "${encfile}" ]]; then
        "_${action}_${type}"
      fi
    done <<<"$(find "${REPO_DIR}" -type f -print | grep -E "${regexp}")"
  done
}



_check_account_to_reencrypt() {
  for account in "${REPO_DIR}"/home-manager/accounts/*/; do
    accountName="$(basename "${account}")"
    if grep -q -r "${accountName}" "${REPO_DIR}/machines/${host}/${user}/" &&
      ! echo "${accountsToReencrypt[@]}" | grep -q "${accountName}"; then
      accountsToReencrypt+=("$accountName")
    fi
  done
}

_reencrypt_accounts() {
  local _type="${type}"
  local regexp

  for account in "${accountsToReencrypt[@]}"; do
    regexp="home-manager/accounts/${account}/"

    if [[ "${_type}" == "all" ]]; then
      type="secret"
    fi

    if [[ "${type}" != "secret" ]]; then
      type="${_type}"
      return
    fi

    regexp+=".*\.enc\.(yaml|json)$"

    while IFS= read -r encfile; do
      if [[ -n "${encfile}" ]] && [[ -f "${encfile}" ]]; then
        "_${action}_${type}"
      fi
    done <<<"$(find "${REPO_DIR}" -type f -print | grep -E "${regexp}")"
  done
}

_process() {
  local regexp="${host}/"

  if [[ -n "${user}" ]]; then
    regexp+="${user}/"
  fi

  if [[ "${type}" == "all" ]]; then
    return
  fi

  case "${type}" in
  key)
    regexp+=".*\.enc\.(asc|txt)$"
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

  if [[ -n "${user}" ]]; then
    _check_account_to_reencrypt
  fi

  _check_common_to_reencrypt
}

_process_user() {
  if [[ "${type}" == "all" ]]; then
    for type in "${!TYPES[@]}"; do
      _process
    done
    type="all"
  else
    _process
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
      _process
    done
    type="all"
  else
    _process
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

  local accountsToReencrypt=()
  local commonsToReencrypt=()
  process_hosts

  if [[ "${action}" == "reencrypt" && "${#accountsToReencrypt[@]}" -gt 0 ]]; then
    _reencrypt_accounts
  fi


  if [[ "${action}" == "reencrypt" && "${#commonsToReencrypt[@]}" -gt 0 ]]; then
    _reencrypt_commons
  fi
}

main "$@"
