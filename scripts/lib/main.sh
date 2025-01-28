#!/usr/bin/env bash

REPO_DIR=$(git rev-parse --show-toplevel)
LIB_DIR="${REPO_DIR}/scripts/lib"

MAIN_FILE="${LIB_DIR}/main.sh"

for lib in "${LIB_DIR}"/*; do
  if [[ "${lib}" != "${MAIN_FILE}" ]]; then
    # shellcheck disable=SC1090
    source "${lib}"
  fi
done
