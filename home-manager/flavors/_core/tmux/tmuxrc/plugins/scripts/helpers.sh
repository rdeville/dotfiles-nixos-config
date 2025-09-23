#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"
SCRIPTNAME="${SCRIPTNAME:-$(basename "$0")}"

get_tmux_option() {
  local option="$1"
  tmux show-option -gqv "${option}"
}

set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "${option}" "${value}"
}

do_interpolation() {
  # $(echo | sed) required to use replacement `\1`
  # shellcheck disable=SC2001
  for segment in $(echo "${value}" | sed "s|#{datstatus-\([a-z-]*\)}|\1 |g"); do
    case "${option}" in
      window-status-current-format)
      "${SCRIPTPATH}/scripts/window.sh" "${option}" "current"
      ;;
      window-status-format)
      "${SCRIPTPATH}/scripts/window.sh" "${option}" "normal"
      ;;
      *)
      "${SCRIPTPATH}/scripts/${segment}.sh" "${option}"
      ;;
    esac
  done
}

update_tmux_option() {
  local option="$1"
  local value
  local new_value

  value="$(get_tmux_option "${option}")"
  new_value=$(do_interpolation "${option}" "${value}")
  set_tmux_option "${option}" "${new_value}"
}

set_segment_settings() {
  local segment=$1

  for default_key in $(
    tmux show-option -g |
      grep "@${segment}-default-" |
      awk '{print $1}'
  ); do
    key=${default_key//default-/}
    default=$(get_tmux_option "${default_key}")
    value=$(get_tmux_option "${key}")

    if [[ -z "${value}" ]]; then
      set_tmux_option "${key}" "${default}"
    elif [[ "${value}" != "${default}" ]]; then
      set_tmux_option "${key}" "${value}"
    fi
  done
}

compute_segment() {
  local string=""
  local segment=$1
  declare -A segment_info

  for default_option in $(
    tmux show-option -g |
      grep "^@${segment}-default-" |
      awk '{print $1}'
  ); do
    segment_option="${default_option//default-/}"
    key="${segment_option//"@${segment}-"/}"
    segment_info[${key}]="$(get_tmux_option "${segment_option}")"
  done

  case "${option}" in
  status-left)
    string+="#[bg=${segment_info[bg]}]"
    string+="${segment_info[separator-left]}"
    ;;
  status-right)
    string+="#[fg=${segment_info[bg]}]"
    string+="${segment_info[separator-right]}"
    ;;
  esac

  string+="#[bg=${segment_info[bg]},fg=${segment_info[fg]}]"
  string+="$(echo -n "${segment_info[format]}")"

  if [[ "${option}" == "status-left" ]]; then
    string+="#[bg=default,fg=${segment_info[bg]}]"
    string+="${segment_info[separator-left]}"
  fi

  echo -n "${string}"
}
