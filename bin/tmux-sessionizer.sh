#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/.dotfiles ~/git ~/Documents -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

# Function to get window index by name
get_window_index_by_name() {
  tmux list-windows -t "$1" -F "#{window_index}:#{window_name}" 2>/dev/null | awk -F: -v name="$2" '$2 == name { print $1 }'
}

# 1-based indexing
nvim_index=1
shell_index=2
dash_index=3

# Create session if needed with just nvim window
if ! tmux has-session -t="$selected_name" 2>/dev/null; then
  tmux new-session -ds "$selected_name" -c "$selected" -n nvim "nvim"
  tmux move-window -s "$selected_name:0" -t "$selected_name:$nvim_index" 2>/dev/null
fi

# Ensure 'nvim' window exists at index 1
existing_nvim_index=$(get_window_index_by_name "$selected_name" "nvim")
if [[ -z $existing_nvim_index ]]; then
  tmux new-window -t "$selected_name:$nvim_index" -n nvim -c "$selected" "nvim"
elif [[ $existing_nvim_index -ne $nvim_index ]]; then
  tmux move-window -s "$selected_name:$existing_nvim_index" -t "$selected_name:$nvim_index"
fi

# Ensure 'shell' window exists at index 2
existing_shell_index=$(get_window_index_by_name "$selected_name" "shell")
if [[ -z $existing_shell_index ]]; then
  tmux new-window -t "$selected_name:$shell_index" -n shell -c "$selected"
elif [[ $existing_shell_index -ne $shell_index ]]; then
  tmux move-window -s "$selected_name:$existing_shell_index" -t "$selected_name:$shell_index"
fi

# Ensure 'dash' window exists at index 3 (for ~/git only)
if [[ $selected == "$HOME/git/"* ]]; then
  existing_dash_index=$(get_window_index_by_name "$selected_name" "dash")
  if [[ -z $existing_dash_index ]]; then
    tmux new-window -t "$selected_name:$dash_index" -n dash -c "$selected" "gh dash"
  elif [[ $existing_dash_index -ne $dash_index ]]; then
    tmux move-window -s "$selected_name:$existing_dash_index" -t "$selected_name:$dash_index"
  fi
fi

# Select nvim window (index 1)
tmux select-window -t "$selected_name:$nvim_index"

# Attach or switch
if [[ -z $TMUX ]]; then
  tmux attach -t "$selected_name"
else
  tmux switch-client -t "$selected_name"
fi
