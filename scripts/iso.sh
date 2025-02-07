#!/usr/bin/env bash
# shellcheck disable=SC2034

# DESCRIPTION: Wraper to manage ISOs config

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

NAME="iso"
DESC="Wrapper to ease building of NixOS iso image"
LEVEL="host"
DEFAULT_ACTION="build"
DEFAULT_HOST="dev"

declare -A OPTIONS
OPTIONS["v"]="--show-trace"
OPTIONS["i"]="--impure"

declare -A ACTIONS
ACTIONS["build"]="Build NixOS ISO image"
ACTIONS["start"]="Start NixOS ISO image"
ACTIONS["mount"]="Mount NixOS ISO image to /tmp/iso/<host>"

_compute_cmd() {
  local cmd_options=""
  compute_override_inputs "$@"

  cmd="nom build \\
  .#nixosConfigurations.${host}.config.system.build.isoImage ${cmd_options}"
}

build_host() {
  local cmd=""

  _compute_cmd "$@"
  _log "INFO" "**Building** VM based on **${host}** with command : "
  _log "INFO" "${cmd}"
  eval "${cmd}"
}

start_host() {
  local cmd=""
  local iso_path="${REPO_DIR}/result/iso/nixos-*.iso"

  build_host "$@"
  # shellcheck disable=SC2086
  if ! ls ${iso_path} &>/dev/null; then
    _log "ERROR" "Iso file ${iso_path} does not exists."
    _log "ERROR" "Run **\`iso build\`** first"
    exit 1
  fi

  cmd="qemu-system-x86_64 \\
  -enable-kvm \\
  -m 2048 \\
  -cdrom ${iso_path}"

  _log "INFO" "**Starting** VM based on **${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  eval "${cmd}"
}

mount_host() {
  local iso_path="${REPO_DIR}/result/iso/nixos-*.iso"
  local mnt_path="/tmp/iso/${host}"
  local cmd="sudo mount -o loop result/iso/nixos-*.iso \"${mnt_path}\""

  # shellcheck disable=SC2086
  if ! ls ${iso_path} &>/dev/null; then
    _log "ERROR" "Iso file ${iso_path} does not exists."
    _log "ERROR" "Run **\`iso build\`** first"
    exit 1
  fi

  _log "INFO" "**Mounting** VM based on **${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  mkdir -p "${mnt_path}"
  eval "${cmd}"
}

umount_host() {
  local iso_path="${REPO_DIR}/result/iso/nixos-*.iso"
  local mnt_path="/tmp/iso/${host}"
  local cmd="umount ${mnt_path}"

  if [[ -d ${mnt_path} ]]; then
    _log "ERROR" "Nothing mounted on ${mnt_path}, nothing to do"
    exit
  fi

  _log "INFO" "**Unmounting** VM based on **${host}** with command : "
  _log "INFO" "${cmd//"${REPO_DIR}/"/}"
  mkdir "${mnt_path}"
  eval "${cmd}"
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
  action=$(check_option_valid "action" "${action}" "ACTIONS" "${DEFAULT_ACTION}")

  local host=${1}
  if [[ -n ${host} ]]; then
    shift
  fi
  check_host "${DEFAULT_HOST}"

  local cmd=""
  process_hosts
}

main "$@"
