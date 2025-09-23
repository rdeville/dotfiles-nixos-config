#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/helpers.sh"

_init_segment(){
  set_tmux_option "@date-default-init" "false"
  if [[ $(get_tmux_option "@date-default-init") != "true" ]]
  then
    set_tmux_option "@date-default-init" "true"
    set_tmux_option "@date-default-bg" "#424242"
    set_tmux_option "@date-default-fg" "#ffffff"
    set_tmux_option "@date-default-format" "   #(date '+%a %d %b | %H:%M') "
    set_tmux_option "@date-default-separator-left" "$(get_tmux_option "@datstatus-separator-left")"
    set_tmux_option "@date-default-separator-right" "$(get_tmux_option "@datstatus-separator-right")"
  fi
}

main() {
  local option=$1
  _init_segment
  set_segment_settings "date"
  compute_segment "date"
}

main "$@"
