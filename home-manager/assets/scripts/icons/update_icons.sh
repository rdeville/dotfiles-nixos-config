#!/usr/bin/env bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" || exit 1 >/dev/null 2>&1 ; pwd -P )"

curl https://raw.githubusercontent.com/carloscuesta/gitmoji/master/packages/gitmojis/src/gitmojis.json \
  | jq '.gitmojis[] | "\(.emoji) \(.description)"' \
  | sed 's/\"//g' \
  > "${SCRIPTPATH}/gitmoji"
