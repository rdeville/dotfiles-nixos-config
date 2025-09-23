#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/helpers.sh"

_init_segment(){
  if [[ $(get_tmux_option "@hostname-default-init") != "true" ]]
  then
    set_tmux_option "@hostname-default-init" "true"
    set_tmux_option "@hostname-default-bg" "#fff176"
    set_tmux_option "@hostname-default-fg" "#212121"
    set_tmux_option "@hostname-default-format" "   #H "
    set_tmux_option "@hostname-default-separator-left" "$(get_tmux_option "@datstatus-separator-left")"
    set_tmux_option "@hostname-default-separator-right" "$(get_tmux_option "@datstatus-separator-right")"
  fi
}

main() {
  local option=$1
  _init_segment
  set_segment_settings "hostname"
  compute_segment "hostname"
}

main "$@"
