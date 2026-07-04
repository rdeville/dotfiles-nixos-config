#!/usr/bin/env bash
# sesh-connect: config-driven wrapper around sesh connect with custom session naming.
#
# Config file (override via SESH_CONNECT_CONFIG env var):
#   ~/.config/tmuxp/sesh-connect.yaml
#
# Rule types (evaluated top-to-bottom, first match wins):
#   path:  exact path match (~ expanded to $HOME)
#   regex: sed -E expression matched against the expanded path;
#          use \1, \2, ... back-references in `name`
#
# Both rule types accept an optional `tmuxp_config` field to override the default.

SELECTED="${1:-}"
[ -z "$SELECTED" ] && exit 0

CONFIG="${SESH_CONNECT_CONFIG:-$HOME/.config/tmuxp/sesh-connect.yaml}"

# sesh --icons prepends a 3-byte nerd font char + space before session names.
# Strip any leading non-ASCII/non-path characters so path matching works.
CLEAN=$(printf '%s' "$SELECTED" | sed 's/^[^[:alnum:]~\/]*//' | sed 's/^ *//')

# Expand ~ to $HOME for path matching
EXPANDED="${CLEAN/#\~/$HOME}"

# No config — fall back to plain sesh
if [ ! -f "$CONFIG" ]; then
  sesh connect "$CLEAN"
  exit 0
fi

DEFAULT_TMUXP="$(yq -r '.defaults.tmuxp_config // "~/.config/tmuxp/code.yaml"' "$CONFIG")"
DEFAULT_TMUXP="${DEFAULT_TMUXP/#\~/$HOME}"

NAME=""
TMUXP_CONFIG="$DEFAULT_TMUXP"

RULE_COUNT="$(yq '.rules | length' "$CONFIG")"

for i in $(seq 0 $((RULE_COUNT - 1))); do
  # --- exact path rule ---
  path_val="$(yq -r ".rules[$i].path // \"\"" "$CONFIG")"
  if [ -n "$path_val" ]; then
    path_expanded="${path_val/#\~/$HOME}"
    if [ "$EXPANDED" = "$path_expanded" ]; then
      NAME="$(yq -r ".rules[$i].name" "$CONFIG")"
      override="$(yq -r ".rules[$i].tmuxp_config // \"\"" "$CONFIG")"
      [ -n "$override" ] && TMUXP_CONFIG="${override/#\~/$HOME}"
      break
    fi
    continue
  fi

  # --- regex rule ---
  regex_val="$(yq -r ".rules[$i].regex // \"\"" "$CONFIG")"
  if [ -n "$regex_val" ]; then
    # Test match: if sed substitutes, output differs from input
    result="$(echo "$EXPANDED" | sed -E "s|${regex_val}|MATCH_PROBE|")"
    if [ "$result" != "$EXPANDED" ]; then
      name_tmpl="$(yq -r ".rules[$i].name" "$CONFIG")"
      NAME="$(echo "$EXPANDED" | sed -E "s|${regex_val}|${name_tmpl}|")"
      override="$(yq -r ".rules[$i].tmuxp_config // \"\"" "$CONFIG")"
      [ -n "$override" ] && TMUXP_CONFIG="${override/#\~/$HOME}"
      break
    fi
  fi
done

if [ -z "$NAME" ]; then
  # No rule matched — let sesh handle it (strips icons internally)
  sesh connect "$CLEAN"
  exit 0
fi

# Desired session already exists → switch directly
if tmux has-session -t "$NAME" 2>/dev/null; then
  tmux switch-client -t "$NAME"
  exit 0
fi

# sesh names git repos by basename; if that session exists, rename rather than
# letting sesh fail on a duplicate name collision.
SESH_NAME="$(basename "$EXPANDED")"
if tmux has-session -t "$SESH_NAME" 2>/dev/null; then
  tmux rename-session -t "$SESH_NAME" "$NAME"
  tmux switch-client -t "$NAME"
  exit 0
fi

# Neither exists — create via tmuxp so the full window layout is applied.
(
  cd "$EXPANDED" || exit 1
  TMUXP_SESSION_NAME="$NAME" tmuxp load -d "$TMUXP_CONFIG"
)
tmux switch-client -t "$NAME"
