# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/git/mesra/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Mesra"

# Split window into panes.
split_v 10
split_h 25

# Run commands.
run_cmd "cd ~/git/mesra && nvim ." 1
run_cmd "cd ~/git/mesra && docker compose -p mesra up -d" 2
run_cmd "cd ~/git/mesra/ && bun install && bun dev" 3

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
