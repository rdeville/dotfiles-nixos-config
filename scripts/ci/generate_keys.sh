#!/usr/bin/env bash

# shellcheck disable=SC2034
SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

REPO_DIR=$(git rev-parse --show-toplevel)
MACHINE_PATH="${REPO_DIR}/machines"

cd "${REPO_DIR}" || exit 1

gen="${REPO_DIR}/scripts/key.sh generate"

for host_path in "${MACHINE_PATH}"/*; do
  if ! [[ "$(basename "${host_path}")" =~ (_templates|nixos-live*) ]] \
    && [[ -f "${host_path}/default.nix" ]]; then
    # Generate host age for common secret and user password encrypted files
    ${gen} "$(basename "${host_path}")" none all
  fi
done


# Workstation, allowed to SSH and use a common secret
${gen} darth-maul rdeville ssh
${gen} darth-maul rdeville age
# Laptop, allowed to SSH and use a common secret
${gen} rey rdeville ssh
${gen} rey rdeville age
# Professional workstation, allowed to SSH and use a common secret
${gen} palpatine rdeville ssh
${gen} palpatine rdeville age

if sps show | yq . &>/dev/null; then
  sps show > "${REPO_DIR}/.sops.yaml"
else
  echo "ERROR - There is a misconfiguration when running 'sps show | yq .'"
fi
