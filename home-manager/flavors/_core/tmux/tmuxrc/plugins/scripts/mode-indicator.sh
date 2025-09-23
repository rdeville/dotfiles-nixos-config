#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"
source "${SCRIPTPATH}/helpers.sh"

_init_segment() {
  if [[ $(get_tmux_option "@mode-indicator-default-init") != "true" ]]; then
    set_tmux_option "@mode-indicator-default-init" "true"

    set_tmux_option "@mode-indicator-default-wait-format" " 󰀡 WAIT "
    set_tmux_option "@mode-indicator-default-wait-bg" "#3F51B5"
    set_tmux_option "@mode-indicator-default-wait-fg" "#fafafa"

    set_tmux_option "@mode-indicator-default-copy-format" "  COPY "
    set_tmux_option "@mode-indicator-default-copy-bg" "#ffeb3b"
    set_tmux_option "@mode-indicator-default-copy-fg" "#212121"

    set_tmux_option "@mode-indicator-default-sync-format" "  SYNC "
    set_tmux_option "@mode-indicator-default-sync-bg" "#ff5722"
    set_tmux_option "@mode-indicator-default-sync-fg" "#fafafa"

    set_tmux_option "@mode-indicator-default-empty-format" "  TMUX "
    set_tmux_option "@mode-indicator-default-empty-bg" "#cddc39"
    set_tmux_option "@mode-indicator-default-empty-fg" "#212121"

    set_tmux_option "@mode-indicator-default-separator-left" "$(get_tmux_option "@datstatus-separator-left")"
    set_tmux_option "@mode-indicator-default-separator-right" "$(get_tmux_option "@datstatus-separator-right")"
  fi
}

_compute_segment() {
  local string=""
  local segment=$1
  declare -A segment_info

  for indicator in "wait" "copy" "sync" "empty"; do
    for default_option in $(
      tmux show-option -g |
        grep "^@${segment}-default" |
        awk '{print $1}'
    ); do
      segment_option="${default_option//default-/}"
      key="${segment_option//"@${segment}-"/}"
      segment_info[${key}]="$(get_tmux_option "${segment_option}")"
    done

    bg="${segment_info[${indicator}-bg]}"
    fg="${segment_info[${indicator}-fg]}"

    segment_info["${indicator}-style-first"]="#[bg=${bg}]#[fg=default]"
    segment_info["${indicator}-style"]="#[bg=${bg}]#[fg=${fg}]"
    segment_info["${indicator}-style-end"]="#[fg=${bg}]#[bg=default]"
  done

  segment_info[format]="#{?client_prefix,${segment_info[wait-format]},#{?pane_in_mode,${segment_info[copy-format]},#{?pane_synchronized,${segment_info[sync-format]},${segment_info[empty-format]}}}}"
  segment_info[style-first]="#{?client_prefix,${segment_info[wait-style-first]},#{?pane_in_mode,${segment_info[copy-style-first]},#{?pane_synchronized,${segment_info[sync-style-first]},${segment_info[empty-style-first]}}}}"
  segment_info[style]="#{?client_prefix,${segment_info[wait-style]},#{?pane_in_mode,${segment_info[copy-style]},#{?pane_synchronized,${segment_info[sync-style]},${segment_info[empty-style]}}}}"
  segment_info[style-end]="#{?client_prefix,${segment_info[wait-style-end]},#{?pane_in_mode,${segment_info[copy-style-end]},#{?pane_synchronized,${segment_info[sync-style-end]},${segment_info[empty-style-end]}}}}"

  case "${option}" in
  status-left)
    string+="${segment_info[style-first]}"
    string+="${segment_info[separator-left]}"
    string+="${segment_info[style]}"
    ;;
  status-right)
    string+="${segment_info[style]}"
    string+="${segment_info[separator-right]}"
    ;;
  esac

  string+="${segment_info[format]}"

  if [[ "${option}" == "status-left" ]]; then
    string+="${segment_info[style-end]}"
  fi

  echo -n "${string}"
}

main() {
  local option="$1"

  _init_segment
  set_segment_settings "mode-indicator"
  # Using custom _compute_segment, not the one in helpers
  _compute_segment "mode-indicator"
}

main "$@"
