#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/helpers.sh"

_init_segment(){
  if [[ $(get_tmux_option "@uptime-default-init") != "true" ]]
  then
    set_tmux_option "@uptime-default-init" "true"
    set_tmux_option "@uptime-default-bg" "#636363"
    set_tmux_option "@uptime-default-fg" "#ffffff"
    set_tmux_option "@uptime-default-format" "   #(uptime | awk -F'( |,|:)+' '{d=h=m=0; if (\$7==\"min\") m=\$6; else {if (\$7~/^day/) {d=\$6;h=\$8;m=\$9} else {h=\$6;m=\$7}}} {if (d!=0) {print d\":\"h\":\"m } else {print h\":\"m'}}) "
    set_tmux_option "@uptime-default-separator-left" "$(get_tmux_option "@datstatus-separator-left")"
    set_tmux_option "@uptime-default-separator-right" "$(get_tmux_option "@datstatus-separator-right")"
  fi
}

main() {
  local option=$1
  _init_segment
  set_segment_settings "uptime"
  compute_segment "uptime"
}

main "$@"
