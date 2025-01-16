#!/usr/bin/env bash
set -e

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

source "$(git rev-parse --show-toplevel)/scripts/_init_logger.sh"

decrypt() {
  while IFS= read -r file; do
    if ! grep "ENC\[AES256_GCM" "${file}" >/dev/null; then
      _log "WARNING" "File ${file} seems already decrypted."
    else
      _log "INFO" "Decrypt file ${file}..."

      if ! sops -d -i "${file}"; then
        _log "ERROR" "Issues during decrypting file ${file}."
      fi
    fi
  done <<<"${secret_files}"

}

encrypt() {
  while IFS= read -r file; do
    if grep "ENC\[AES256_GCM" "${file}" >/dev/null; then
      _log "WARNING" "File ${file} seems already encrypted."
    else
      _log "INFO" "Encrypt file ${file}..."

      if ! sops -e -i "${file}"; then
        _log "ERROR" "Issues during encrypting file ${file}."
      fi
    fi
  done <<<"${secret_files}"
}

reencrypt() {
  while IFS= read -r file; do
    _log "INFO" "Reencrypt file ${file}..."

    if ! sops -d -i "${file}"; then
      _log "ERROR" "Issues during decrypting file ${file}."
    elif ! sops -e -i "${file}"; then
      _log "ERROR" "Issues during encrypting file ${file}."
    fi
  done <<<"${secret_files}"
}

commit() {
  for host in "${repo_dir}/configs/hosts/"*; do
    if [[ -d "${host}" ]]; then
      hostname=$(basename "${host}")

      for user in "${host}/"*; do
        if [[ -d "${user}" ]]; then
          username=$(basename "${user}")

          if git status | grep "${user/"${repo_dir}/"/}" >/dev/null; then
            _log "INFO" "Applying commit for **configs/hosts/${hostname}/${username}**"

            if ! (
              git commit \
                "${user/"${repo_dir}/"/}" \
                -m "🔐(cfg/hosts/${hostname}): Update user ${username} secrets" >/dev/null
            ); then
              _log "ERROR" "Something went wrong when commiting **configs/hosts/${hostname}/${username}**"
            fi
          else
            _log "INFO" "Nothing to commit for **configs/hosts/${hostname}/${username}**"
          fi
        fi
      done

      if git status | grep "${host/"${repo_dir}/"/}" >/dev/null; then
        _log "INFO" "Applying commit for **configs/hosts/${hostname}**"

        if ! (
          git commit \
            "${host/"${repo_dir}/"/}" \
            -m "🔐(cfg/hosts/${hostname}): Update os secrets" >/dev/null
        ); then
          _log "ERROR" "Something went wrong when commiting **configs/hosts/${hostname}/${username}**"
        fi
      else
        _log "INFO" "Nothing to commit for **configs/hosts/${hostname}**"
      fi
    fi
  done
}

update_keys() {
  age="age.enc.txt"

  echo "    # Personnal Superuser"
  echo "  - &rdeville age1z5w53ch2ym5qmhew239j7qh0q0ax72daq42qvvwexferta2yrprsf4kes9"

  for host in "${repo_dir}/configs/hosts/"*; do
    if [[ -d ${host} ]]; then
      hostname=$(basename "${host}")
      private="${host}/${age}"
      echo "    # ${hostname^}"

      if [[ -f ${private} ]] && grep "ENC\[AES256_GCM" "${private}" >/dev/null; then
        anchor="&os-${hostname}"
        pub="$(sops -d "${private}" | grep "public key: " | cut -d ":" -f 2)"
        echo "  - ${anchor}${pub}"
      fi

      for user in "${host}/"*; do
        private="${user}/${age}"
        username=$(basename "${user}")

        if [[ -d "${user}" ]] && [[ -f ${private} ]] && grep "ENC\[AES256_GCM" "${private}" >/dev/null; then
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


  if [[ "${type}" == "file" ]];  then
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
  for host in "${repo_dir}/configs/hosts/"*; do
    if [[ -d ${host} ]]; then
      hostname=$(basename "${host}")
      private="${host}/${age}"
      comment=""

      for user in "${host}/"*; do
        if [[ -d "${user}" ]]; then
          username=$(basename "${user}")
          anchor="hm-${username}-${hostname}"
          if [[ -z "${comment}" ]]; then
            comment="${hostname^}"
          fi
          _show_path_regex "${hostname}/${username}" "${anchor}" "${comment}"
        fi
      done

      anchor="os-${hostname}"
      _show_path_regex "${hostname}" "${anchor}"
    fi
  done
}

update_accounts_rules() {
  for account_path in "${repo_dir}/configs/accounts/"*; do
    if [[ -d "${account_path}" ]]; then
      account=$(basename "${account_path}")
      occurrences=$(grep -lr -E "${account}" "${repo_dir}/configs/hosts")

      _show_path_regex  "${account}" "" "${account}"
      for file in ${occurrences}; do
        user_path=$(dirname "${file}")
        user=$(basename "${user_path}")
        host_path=$(dirname "${user_path}")
        host=$(basename "${host_path}")
        echo "        - *hm-${user}-${host}"
      done
    fi
  done
}

update_common_secrets_rules() {
  dir="common_secrets"
  for secret in "${repo_dir}/${dir}/"*; do
    secret="${dir}/$(basename "${secret}")"
    occurrences=$(grep -lr -E "${secret}" "${repo_dir}/configs/hosts")

    _show_path_regex  "${secret}" "" "" "file"
    for file in ${occurrences}; do
      user_path=$(dirname "${file}")
      user=$(basename "${user_path}")
      host_path=$(dirname "${user_path}")
      host=$(basename "${host_path}")
      echo "        - *hm-${user}-${host}"
    done
  done
}

update() {
  echo "keys:"
  update_keys

  echo "creation_rules":
  update_hosts_rules
  update_accounts_rules
  update_common_secrets_rules

  _show_path_regex "" "" "Default encryption rules"
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  init_logger

  local repo_dir
  local secret_regexp
  local secret_files

  repo_dir=$(git rev-parse --show-toplevel)
  # shellcheck disable=SC2016
  secret_regexp=$(
    yq \
      '.creation_rules.[] as $item ireduce ([]; . += ($item.path_regex | sub("\\\/","/"))) | join("|")' \
      "${repo_dir}/.sops.yaml"
  )
  secret_files=$(find "${repo_dir}" -type f -print | grep -E "${secret_regexp}")

  if [[ $# == 0 ]]; then
    _log "ERROR" "Script one of the following param : "
    _log "ERROR" " -e: Encrypt all encrypted files"
    _log "ERROR" " -d: Decrypt all encrypted files"
    _log "ERROR" " -r: Decrypt and encrypt all encrypted files"
    _log "ERROR" " -c: Commit reencrypted files"
    _log "ERROR" " -u: Generate updated public AGE key with anchor to stdout"
    exit 1
  fi

  while getopts "edruc" opt; do
    _log "DEBUG" "Process args : ${opt}"
    case ${opt} in
    e) # encrypt
      encrypt
      ;;
    d) # profile
      decrypt
      ;;
    u) # update, update .sops.yaml and reencrypt
      update
      # reencrypt
      ;;
    r) # profile
      reencrypt
      ;;
    c) # profile
      commit
      ;;
    *)
      _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
      exit 1
      ;;
    esac
  done
}

main "$@"
