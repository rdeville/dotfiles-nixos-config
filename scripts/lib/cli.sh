#!/usr/bin/env bash

# CLI Management functions
compute_override_inputs() {
  # Allow to easily manage inputs override
  # To use it, create a file "${REPO_DIR}/scripts/local_inputs.sh" with
  # following content :
  # ```bash
  # #!/usr/bin/env bash
  # unset inputs
  # declare -A inputs
  #
  # # Create an array with local inputs such that entry is input name and value
  # # is the path to the local flake
  # inputs[INPUT_NAME]="PATH_TO_LOCAL_FLAKE"
  #
  # export inputs
  # ````
  local local_inputs_file
  local_inputs_file="${REPO_DIR}/scripts/local_inputs.sh"

  if [[ -f "${local_inputs_file}" ]]; then
    # shellcheck disable=SC1090
    source "${local_inputs_file}"

    # shellcheck disable=2154
    for input in "${!inputs[@]}"; do
      cmd_options+=" \\
      --override-input ${input} ${inputs[$input]} "
    done
  fi
}

parse_args() {
  local opts="${!OPTIONS[*]}"

  while getopts "h${opts// /}" opt; do
    if [[ "${opt}" == "h" ]]; then
      help
    fi

    _log "DEBUG" "Process args : ${opt}"
    if [[ -n ${OPTIONS[$opt]} ]]; then
      cmd_options+=" ${OPTIONS[$opt]}"
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
