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

# Return focus to the most-recently-active non-sidebar pane in a session.
# Called after switching to an existing session so the sidebar pane (if it
# was the last active one) does not keep focus.
_focus_main_pane() {
  local target="$1"
  local pane
  pane=$(tmux list-panes -t "${target}" \
    -F '#{pane_last_activity} #{pane_id} #{pane_current_command}' \
    | grep -v 'tmux-agent-sidebar' \
    | sort -rn \
    | awk 'NR==1{print $2}')
  [ -n "$pane" ] && tmux select-pane -t "$pane" 2>/dev/null
}

# After creating a new session, tmuxp already focused the right pane.
# tmux-agent-sidebar auto-creates its pane after @sidebar_auto_create_delay
# seconds and steals focus. Capture the tmuxp-designated pane id now and
# reselect it once the sidebar delay has elapsed.
_refocus_after_sidebar() {
  local target="$1"
  local pane_id="$2"
  local delay
  delay=$(tmux show-option -gqv @sidebar_auto_create_delay 2>/dev/null)
  delay="${delay:-0}"
  # Add 0.5 s margin so the sidebar pane is fully created before we reselect.
  local wait
  wait=$(awk "BEGIN{printf \"%.1f\", $delay + 0.5}")
  (sleep "$wait" && tmux select-pane -t "$pane_id" 2>/dev/null) &
}

# Desired session already exists → switch and restore last non-sidebar pane.
if tmux has-session -t "$NAME" 2>/dev/null; then
  tmux switch-client -t "$NAME"
  _focus_main_pane "$NAME"
  exit 0
fi

# sesh names git repos by basename; if that session exists, rename rather than
# letting sesh fail on a duplicate name collision.
SESH_NAME="$(basename "$EXPANDED")"
if tmux has-session -t "$SESH_NAME" 2>/dev/null; then
  tmux rename-session -t "$SESH_NAME" "$NAME"
  tmux switch-client -t "$NAME"
  _focus_main_pane "$NAME"
  exit 0
fi

# Neither exists — create via tmuxp so the full window layout is applied.
(
  cd "$EXPANDED" || exit 1
  TMUXP_SESSION_NAME="$NAME" tmuxp load -d "$TMUXP_CONFIG"
)
tmux switch-client -t "$NAME"
# Capture the tmuxp-designated pane before the sidebar delay fires.
TMUXP_FOCUS=$(tmux display-message -p -t "${NAME}" '#{pane_id}')
_refocus_after_sidebar "$NAME" "$TMUXP_FOCUS"
