#!/usr/bin/env bash

# CLI Management functions
compute_override_inputs() {
  local local_inputs_file
  local_inputs_file="${REPO_DIR}/scripts/local_inputs.sh"

  # shellcheck source=../local_inputs.sh
  source "${local_inputs_file}"

  # shellcheck disable=2154
  for input in "${!inputs[@]}"; do
    cmd_options+="\\
  --override-input ${input} ${inputs[$input]} "
  done
}

parse_args() {
  local opts="${!OPTIONS[*]}"

  while getopts "h${opts// /}" opt; do
    if [[ "${opt}" == "h" ]]; then
      help
    fi

    _log "DEBUG" "Process args : ${opt}"
    if [[ -n ${OPTIONS[$opt]} ]]; then
      cmd_options+="${OPTIONS[$opt]}"
    else
      _log "ERROR" "Unsupported argument : ${opt} ${OPTARG}"
      exit 1
    fi
  done
}

show_options_string() {
  option_str=""
  # shellcheck disable=SC2154
  for opt in "${!opts_array[@]}"; do
    # shellcheck disable=SC2001
    option_str+="${opt} "
  done
  # Remove trailing space
  option_str="${option_str% }"
  echo "${option_str// /"|"}"
}

show_options_regexp() {
  echo "($(show_options_string))"
}
