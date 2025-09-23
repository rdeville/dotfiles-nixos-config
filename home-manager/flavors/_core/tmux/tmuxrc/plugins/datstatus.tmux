#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/scripts/helpers.sh"

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
  update_tmux_option "window-status-format"
  update_tmux_option "window-status-current-format"
}

main "$@"
