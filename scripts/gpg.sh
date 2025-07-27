#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Update GPG keys expiricy or import them

set -e

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)

declare -A gpgKeys
gpgKeys["pro@romaindeville.fr"]="05BE537034A8992CE572A6B0700E80E57C25C99A"
gpgKeys["contact@romaindeville.fr"]="9131F698BAA59C5566C380A52685E63009552593"
gpgKeys["admin@romaindeville.fr"]="39D2820D18C4C9665BD53B4373846D28E06457B0"

masterExt="private.master.asc"
subkeyExt="private.subkey.asc"
publicExt="public.asc"
revocExt="revocation.asc"
gpgFiles=(
  "${masterExt}"
  "${subkeyExt}"
  "${publicExt}"
  "${revocExt}"
)

usage() {
  _log "INFO" "Usage :"
  _log "INFO" "  - Show this help"
  _log "INFO" "    **./gpg.sh help**"
  _log "INFO" ""
  _log "INFO" "  - Import subkeys in GPG for this machine"
  _log "INFO" "    **./gpg.sh import**"
  _log "INFO" ""
  _log "INFO" "  - Update expiricy for all keys"
  _log "INFO" "    **./gpg.sh set-expire DAYS**"
  _log "INFO" "    Where **DAYS** is the number expiricy days from today"
}

check_param() {
  if [[ $# -eq 0 ]]; then
    _log "ERROR" "At least one argument must be provided"
    usage
    exit 1
  elif [[ $# -gt 2 ]]; then
    _log "ERROR" "At most two arguments must be provided"
    usage
    exit 1
  fi

  case "$1" in
  help)
    usage
    exit 0
    ;;
  import)
    action="$1"
    ;;
  set-expire)
    action="$1"
    if [[ $# -ne 2 ]]; then
      _log "ERROR" "When using \`set-expire\` option, you MUST provide number of days"
      usage
      exit 1
    fi
    days="$2"
    ;;

  esac

  _log "INFO" "Will extend keys expiricy by $1 days."
}

export_old_keys() {
  _log "INFO" "  Exporting old keys"
  for ext in "${gpgFiles[@]}"; do
    kp attachment-export \
      "/gpg/${key}" \
      "${key}.${ext}" \
      "${dirOld}/${key}.${ext}"
  done
}

remove_old_keys() {
  _log "INFO" "  Remove old keys KP"
  for ext in "${gpgFiles[@]}"; do
    kp attachment-rm \
      "/gpg/${key}" \
      "${key}.${ext}"
  done
}

backup_old_keys() {
  _log "INFO" "  Backing up old keys KP"
  local date
  date=$(date '+%Y-%m-%d-%H-%M')

  _log "WARNING" "Please lock KP before continue to avoid update conflict."
  _log "WARNING" "Press Enter once done."
  read -r

  for ext in "${gpgFiles[@]}"; do
    kp attachment-import \
      "/gpg/${key}" \
      "${date}.${key}.${ext}" \
      "${dirOld}/${key}.${ext}"
  done
}

update_expiricy() {
  _log "INFO" "  Update expiricy"
  kp show "/gpg/${key}" |
    gpg --batch --import "${dirOld}/${key}.${masterExt}"
  gpg --quick-set-expire "${fingerprint}" 705
  _log "WARNING" "  Manual action is required to update expiricy of subkeys."
  _log "WARNING" "  GPG prompt will automatically be open, once open type following"
  _log "WARNING" "    - key <ID> # Where <ID> is the ID of subkeys, repeat if needed"
  _log "WARNING" "    - expire # Interactive prompt will ask number of days"
  _log "WARNING" "    - save"
  gpg --edit-key "${fingerprint}"
  _log "INFO" "You should see subkeys below"
  gpg -K
}

export_new_keys() {
  _log "INFO" "  Export new keys"
  kp show "/gpg/${key}" |
    gpg --batch --armor --export "${key}" >"${dirNew}/${key}.${publicExt}"
  gpg --armor --gen-revoke "${key}" >"${dirNew}/${key}.${revocExt}"
  gpg --armor --export-secret-keys "${key}" >"${dirNew}/${key}.${masterExt}"
  gpg --armor --export-secret-subkeys "${key}" >"${dirNew}/${key}.${subkeyExt}"
}

store_new_keys() {
  _log "INFO" "  Store new keys in KP"
  for ext in "${gpgFiles[@]}"; do
    kp attachment-import \
      "/gpg/${key}" \
      "${key}.${ext}" \
      "${dirNew}/${key}.${ext}"
  done
}

import_key() {
  _log "INFO" "  Import key"
  kp show "/gpg/${key}" |
    gpg --batch --import "${dir}/${key}.${subkeyExt}"
}

remove_master() {
  _log "INFO" "  Remove master keys from local GPG"
  local dir=${dirNew}
  gpg --delete-secret-keys "${key}"
  import_key
}

process_keys() {
  _log "INFO" "  Processing key **${key}**"
  dirOld="/tmp/gpg.old"
  dirNew="/tmp/gpg.new"
  mkdir -p "${dirOld}"
  mkdir -p "${dirNew}"

  export_old_keys
  update_expiricy
  export_new_keys
  backup_old_keys
  remove_old_keys
  store_new_keys
  remove_master

  _log "INFO" "  Clean temporary directory"
  rm -rf "${dirOld}"
  rm -rf "${dirNew}"
}

import_keys() {
  _log "INFO" "  Importing key **${key}**"
  local dirOld="/tmp/gpg.old"
  local dir=${dirOld}

  mkdir -p "${dirOld}"

  export_old_keys
  import_key

  _log "INFO" "  Clean temporary directory"
  rm -rf "${dirOld}"
}

main() {
  export DEBUG_LEVEL="${DEBUG_LEVEL:-INFO}"
  source "${REPO_DIR}/scripts/lib/main.sh"
  init_logger

  local action
  local days

  check_param "$@"

  case "${action}" in
  import)
    _log "INFO" "Importing keys"
    for key in "${!gpgKeys[@]}"; do
      local fingerprint="${gpgKeys[$key]}"
      import_keys
    done
    ;;
  set-expire)
    _log "INFO" "Updating expiricy by ${days}"
    for key in "${!gpgKeys[@]}"; do
      local fingerprint="${gpgKeys[$key]}"
      process_keys
    done
    ;;
  esac
}

main "$@"
