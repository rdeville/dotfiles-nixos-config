#!/usr/bin/env bash
# Called by the after-new-window hook to create the agent sidebar only on
# windows that have the @sidebar window option set to "on".
window_id="$1"
pane_path="$2"
delay="$3"
bin="$4"

val=$(tmux show-option -wqv -t "$window_id" @sidebar 2>/dev/null)
[ "$val" = "on" ] || exit 0
sleep "$delay"
"$bin" toggle --create-only "$window_id" "$pane_path"
