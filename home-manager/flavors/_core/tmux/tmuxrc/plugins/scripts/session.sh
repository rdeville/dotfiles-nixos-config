#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/helpers.sh"

_init_segment(){
  if [[ $(get_tmux_option "@sessions-default-init") != "true" ]]
  then
    set_tmux_option "@sessions-default-init" "true"
    set_tmux_option "@sessions-default-bg" "#4E342E"
    set_tmux_option "@sessions-default-fg" "#ffffff"
    set_tmux_option "@sessions-default-format" "   #S "
    set_tmux_option "@sessions-default-separator-left" "$(get_tmux_option "@datstatus-separator-left")"
    set_tmux_option "@sessions-default-separator-right" "$(get_tmux_option "@datstatus-separator-right")"
  fi
}

main() {
  local option=$1
  _init_segment
  set_segment_settings "sessions"
  compute_segment "sessions"
}

main "$@"
