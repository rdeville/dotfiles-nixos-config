#!/usr/bin/env bash

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1
  pwd -P
)"

update_unicode() {
  local version='14.0'
  local url="https://www.unicode.org/Public/emoji/${version}/emoji-test.txt"
  local out="${SCRIPTPATH}/emojis.txt"

  curl --silent --compressed "${url}" |
    sed -nE 's/^.+fully-qualified\s+#\s(\S+) E[0-9.]+ / \1 /p' |
    sed -e "s/^ //g" >"${out}"
}

update_gitmoji() {
  local url="https://raw.githubusercontent.com/carloscuesta/gitmoji/master/packages/gitmojis/src/gitmojis.json"
  local out="${SCRIPTPATH}/gitmoji.txt"
  curl --silent --compressed "${url}" |
    jq '.gitmojis[] | .emoji + " " + .code + " " + .description ' |
    sed 's/"//g' | tr '[:upper:]' '[:lower:]' >"${out}"
}

main() {
  echo "Updating Unicode"
  update_unicode
  echo "Updating Gitmoji"
  update_gitmoji
}

main "$@"
