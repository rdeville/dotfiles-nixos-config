#!/usr/bin/env bash

# Sops related method
encrypt() {
  local from_reencrypt="${1}"

  # shellcheck disable=SC2154
  if grep "ENC\[AES256_GCM" "${encfile}" >/dev/null; then
    _log "WARNING" "File ${encfile} seems already encrypted."
  else
    if [[ -z "${from_reencrypt}" ]]; then
      _log "INFO" "Encrypt file ${encfile//"${MACHINE_PATH}/"/}..."
    fi

    if ! sops -e -i "${encfile}"; then
      _log "ERROR" "Issues during encrypting file ${encfile}."
    fi
  fi
}

decrypt() {
  local from_reencrypt="${1}"

  if ! grep "ENC\[AES256_GCM" "${encfile}" >/dev/null; then
    _log "WARNING" "File ${encfile} seems already decrypted."
  else
    if [[ -z "${from_reencrypt}" ]]; then
      _log "INFO" "Decrypting file ${encfile//"${MACHINE_PATH}/"/}..."
    fi

    if ! sops -d -i "${encfile}"; then
      _log "ERROR" "Issues during decrypting file ${encfile}."
    fi
  fi
}

reencrypt() {
  _log "INFO" "Backup ${encfile//"${MACHINE_PATH}/"/}"
  cp "${encfile}" "${encfile}.bak"

  _log "INFO" "Reencrypting file ${encfile//"${MACHINE_PATH}/"/}..."
  decrypt "true"
  encrypt "true"
}

# Key management related method
compute_key_path() {
  local path=$1
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
