#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/.dotfiles ~/git -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

# Returns window index by name, or empty string if not found
get_window_index_by_name() {
  tmux list-windows -t "$1" -F "#{window_index}:#{window_name}" 2>/dev/null | awk -F: -v name="$2" '$2 == name { print $1 }'
}

# Ensure session exists
if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected" -n nvim "nvim ."
fi

# nvim → index 0
nvim_index=$(get_window_index_by_name "$selected_name" "nvim")
if [[ -z $nvim_index ]]; then
  tmux new-window -t "$selected_name:0" -n nvim -c "$selected" "nvim ."
elif [[ $nvim_index -ne 0 ]]; then
  tmux move-window -s "$selected_name:$nvim_index" -t "$selected_name:0"
fi

# shell → index 1
shell_index=$(get_window_index_by_name "$selected_name" "shell")
if [[ -z $shell_index ]]; then
  tmux new-window -t "$selected_name:1" -n shell -c "$selected"
elif [[ $shell_index -ne 1 ]]; then
  tmux move-window -s "$selected_name:$shell_index" -t "$selected_name:1"
fi

# dash → index 2 (only for ~/git)
if [[ $selected == "$HOME/git/"* ]]; then
  dash_index=$(get_window_index_by_name "$selected_name" "dash")
  if [[ -z $dash_index ]]; then
    tmux new-window -t "$selected_name:2" -n dash -c "$selected" "gh dash"
  elif [[ $dash_index -ne 2 ]]; then
    tmux move-window -s "$selected_name:$dash_index" -t "$selected_name:2"
  fi
fi

# Focus on nvim (index 0)
tmux select-window -t "$selected_name:0"

# Attach or switch
if [[ -z $TMUX ]]; then
  tmux attach -t "$selected_name"
else
  tmux switch-client -t "$selected_name"
fi
