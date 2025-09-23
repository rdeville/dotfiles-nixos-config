#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/helpers.sh"

_init_segment() {
  if [[ $(get_tmux_option "@window-default-init") != "true" ]]
  then
    set_tmux_option "@window-default-init" "true"

    set_tmux_option "@window-default-normal-bg" "#8bc34a"
    set_tmux_option "@window-default-normal-fg" "#76ff03"

    set_tmux_option "@window-default-current-bg" "#76ff03"
    set_tmux_option "@window-default-current-fg" "#000000"

    for mode in "normal" "current"; do
      set_tmux_option "@window-default-${mode}-format" " #I:#W "
      set_tmux_option "@window-default-${mode}-separator-left" "$(get_tmux_option "@datstatus-separator-left")"
      set_tmux_option "@window-default-${mode}-separator-right" "$(get_tmux_option "@datstatus-separator-right")"
    done
  fi
}

_compute_segment() {
  local string=""
  local segment=$1
  declare -A segment_info

  for default_option in $(
    tmux show-option -g |
      grep "^@${segment}-default-${state}" |
      awk '{print $1}'
  ); do
    segment_option="${default_option//default-/}"
    key="${segment_option//"@${segment}-${state}-"/}"
    segment_info[${key}]="$(get_tmux_option "${segment_option}")"
  done


 status_bg=$(get_tmux_option "@status-bg")

 case "${option}" in
  status-left)
    string+="#[bg=${segment_info[bg]},fg=${segment_info[fg]}]"
    string+="${segment_info[separator-left]}"
    ;;
  status-right)
    string+="#[fg=${segment_info[bg]}]"
    string+="${segment_info[separator-right]}"
    ;;
  *)
    string+="#[fg=${status_bg},bg=${segment_info[bg]}]"
    string+="${segment_info[separator-left]}"
    ;;
  esac

  string+="#[bg=${segment_info[bg]},fg=${segment_info[fg]}]"
  string+="$(echo -n "${segment_info[format]}")"

  string+="#[bg=default,fg=${segment_info[bg]}]"
  string+="${segment_info[separator-left]}"

  echo -n "${string}"
}

main() {
  local option=$1
  local state=$2

  _init_segment
  set_segment_settings "window"
  _compute_segment "window"
}

main "$@"
