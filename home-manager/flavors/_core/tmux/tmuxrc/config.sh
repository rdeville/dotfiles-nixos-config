#!/usr/bin/env bash
# shellcheck disable=SC2154,SC2034

SCRIPTPATH="$(
  cd -- "$(dirname "$0")" || exit 1 >/dev/null 2>&1
  pwd -P
)"

# Setup pane colorations
# -----------------------------------------------------------------------------
pane="#{?#{pane_active},#[fg=#{@pane-active-border-bg}]#[bg=#{@pane-active-border-fg}],#[fg=#{@pane-border-bg}]#[bg=#{@pane-border-fg}]}"

if [[ "$(uname)" == "Darwin" ]]; then
  ps_cmd="#(ps -t #{pane_tty} -o args= | head -n 1)"
else
  ps_cmd="#(ps --no-headers -t #{pane_tty} -o args -O-c \
    | sed \
      -e 's|.*\(nvim\).*|\1|g' \
      -e 's|^-||' \
      -e 's|.*nix-profile\/bin\/||g' \
    )"
fi

tmux set -g pane-border-format "${pane} #{pane_index}:${ps_cmd} "

# Only show pane status if more than one pane
tmux set-hook -g -w pane-focus-in "set-option -Fw pane-border-status '#{?#{e|>:#{window_panes},1},top,off}'"
