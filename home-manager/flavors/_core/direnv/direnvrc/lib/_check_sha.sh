#!/usr/bin/env bash

_check_sha() {
  # """Ensure the sha of a file is valid
  #
  # **NAME**
  #   _check_sha [FILE]
  #
  # **DESCRIPTION**
  #   Ensure the sha of a file provided as argument corresponding the value of
  #   a previously computed sha to ensure the file has not been modified.
  #
  # **OPTIONS**
  #   **FILE**: string, path to the file to test
  #
  # **EXAMPLES**
  #   _check_sha filename.ext
  #
  # **RETURN CODE**
  #   0 if sha is valid
  #   1 if sha is not valid
  #
  # """
  _log "TRACE" "direnv: _check_sha()"

  local file

  [[ "${1}" =~ ^\/ ]] && file="${1}" || file="${PWD}/${1:-".env"}"

  # shellcheck disable=SC2155
  local file_name="$(basename "${file}" | sed -e "s/^\.//")"
  # shellcheck disable=SC2155
  local file_dir="$(dirname "${file}")"
  local sha_file="${XDG_CACHE_HOME:-${HOME}/.cache}/direnv${file_dir/${HOME}/}/${file_name}.sha"
  local cache_file="${XDG_CACHE_HOME:-${HOME}/.cache}/direnv${file_dir/${HOME}/}/${file_name}"

  if ! [[ -f "${sha_file}" ]]; then
    _log "INFO" "direnv: Sha of **\`${file/${HOME}/\~}\`** does not exist yet."
    _log "INFO" "direnv: Will be computed in to **\`${sha_file/${HOME}/\~}\`** authorized."
    ! [[ -d "$(dirname "${sha_file}")" ]] && mkdir -p "$(dirname "${sha_file}")"
    shasum "${file}" >"${sha_file}"
    cp "${file}" "${cache_file}"
  elif ! shasum -c "${sha_file}" &>/dev/null; then
    _log "ERROR" "direnv: Sha of **\`${file/${HOME}/\~}\`** differs from **\`${sha_file/${HOME}/\~}\`**."
    _log "ERROR" "direnv: To see the diff, run:"
    _log "ERROR" "**\`vimdiff ${cache_file/${HOME}/\~} ${file/${HOME}/\~}\`** to see the diff"
    return 1
  fi
}

# vim: ft=bash
