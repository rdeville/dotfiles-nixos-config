#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wrapper to manage sops configuration

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="sops"
DESC="Wrapper to ease .sops.yaml management"
LEVEL=""
DEFAULT_ACTION="show"

declare -A OPTIONS

declare -A ACTIONS
ACTIONS["show"]="Show the .sops.yaml configuration for each hosts/users."

update_keys() {
  age="age.enc.txt"

  echo "    # Personal Superuser"
  echo "  - &rdeville age1z5w53ch2ym5qmhew239j7qh0q0ax72daq42qvvwexferta2yrprsf4kes9"

  for host in "${MACHINE_PATH}/"*; do
    if [[ -d ${host} ]] && ! [[ "${host}" =~ _.*$ ]]; then
      hostname=$(basename "${host}")
      private="${host}/_keys/${age}"

      if [[ -f ${private} ]] && grep "ENC\[AES256_GCM" "${private}" >/dev/null; then
        echo "    # ${hostname^}"
        anchor="&os-${hostname}"
        pub="$(sops -d "${private}" | grep "public key: " | cut -d ":" -f 2)"
        echo "  - ${anchor}${pub}"
      fi

      for user in "${host}/"*; do
        private="${user}/_keys/${age}"
        username=$(basename "${user}")

        if [[ -d "${user}" ]] && ! [[ "${user}" =~ _.*$ ]] &&
          [[ -f ${private} ]] &&
          grep "ENC\[AES256_GCM" "${private}" >/dev/null; then
          anchor="&hm-${username}-${hostname}"
          pub="$(sops -d "${private}" | grep "public key: " | cut -d ":" -f 2)"
          echo "  - ${anchor}${pub}"
        fi
      done

    fi
  done
}

_show_path_regex() {
  local dir=${1}
  local anchor=${2}
  local comment=${3}
  local type="${4:-dir}"

  if [[ "${type}" == "file" ]]; then
    echo "  - path_regex: ${dir}$"
  elif [[ -n "${dir}" ]]; then
    echo "  - path_regex: ${dir}/.*\.enc\.(yaml|json|asc|txt)$"
  else
    echo "  - path_regex: .*\.enc\.(yaml|json|asc|txt)$"
  fi

  if [[ -n "${comment}" ]]; then
    echo "    # ${comment^}"
  fi
  echo "    key_groups:"
  echo "      - age:"
  echo "        - *rdeville"
  if [[ -n "${anchor}" ]]; then
    echo "        - *${anchor}"
  fi
}

update_hosts_rules() {
  for host in "${MACHINE_PATH}/"*; do
    if [[ -d ${host} ]] && ! [[ "${host}" =~ _.*$ ]]; then
      hostname=$(basename "${host}")
      comment=""

      for user in "${host}/"*; do
        private="${host}/${user}/_keys/${age}"
        if [[ -d "${user}" && -f "${private}" ]] && ! [[ "${user}" =~ _.*$ ]]; then
          username=$(basename "${user}")
          anchor="hm-${username}-${hostname}"
          if [[ -z "${comment}" ]]; then
            comment="${hostname^}"
          fi
          if [[ -f "${user}/default.nix" ]]; then
            _show_path_regex "${hostname}/${username}" "${anchor}" "${comment}"
          fi
        fi
      done

      private="${host}/_keys/${age}"
      anchor="os-${hostname}"
      if [[ -f "${host}/default.nix" && -f "${private}" ]]; then
        _show_path_regex "${hostname}" "${anchor}"
      fi
    fi
  done
}

update_accounts_rules() {
  for account_path in "${REPO_DIR}/home-manager/accounts/"*; do
    if [[ -d "${account_path}" ]]; then
      account=$(basename "${account_path}")
      occurrences=$(grep -lr -E "${account}" "${MACHINE_PATH}")

      _show_path_regex "${account}" "" "${account}"
      for file in ${occurrences}; do
        user_path=$(dirname "${file}")
        user_age="${user_path}/_keys/${age}"
        user=$(basename "${user_path}")

        host_path=$(dirname "${user_path}")
        host=$(basename "${host_path}")

        if ! [[ "${host}" =~ _.*$ ]] &&
          ! [[ "${user}" =~ _.*$ ]] &&
          [[ -f "${user_age}" ]]; then
          echo "        - *hm-${user}-${host}"
        fi
      done
    fi
  done
}

update_common_secrets_rules() {
  dir="common_secrets"
  for secret in "${REPO_DIR}/${dir}/"*; do
    secret="${dir}/$(basename "${secret}")"
    occurrences=$(grep -lr -E "${secret}" "${MACHINE_PATH}")

    _show_path_regex "${secret}" "" "" "file"
    for file in ${occurrences}; do
      user_path=$(dirname "${file}")
      user_age="${user_path}/_keys/${age}"
      user=$(basename "${user_path}")

      host_path=$(dirname "${user_path}")
      host_age="${host_path}/_keys/${age}"
      host=$(basename "${host_path}")

      if ! [[ "${host}" =~ _.*$ ]] &&
        ! [[ "${user}" =~ _.*$ ]]; then
        if [[ "${host}" == "machines" && -f "${user_age}" ]]; then
          echo "        - *os-${user}"
        elif [[ -f "${user_age}" ]]; then
          echo "        - *hm-${user}-${host}"
        fi
      fi
    done
  done
}

show() {
  echo "keys:"
  update_keys

  echo "creation_rules":
  echo "  - path_regex: age\.enc\.txt"
  echo "  # AGE key files can only be decrypted by @rdeville"
  echo "    key_groups:"
  echo "      - age:"
  echo "        - *rdeville"

  update_hosts_rules
  update_accounts_rules
  update_common_secrets_rules

  _show_path_regex "" "" "Default encryption rules"
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
  action=$(check_option_valid "action" "${action}" "ACTIONS" "${DEFAULT_ACTION}")

  "${action}"
}

main "$@"
