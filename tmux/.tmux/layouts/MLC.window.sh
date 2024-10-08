# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/git/mlc/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "MLC"

# Split window into panes.
split_v 10
split_h 25
split_h 25

# Run commands.
run_cmd "cd ~/git/mlc/src && nvim ." 1
run_cmd "cd ~/git/mlc/src" 2
run_cmd "cd ~/git/mlc/src && make tailwind" 3
run_cmd "cd ~/git/mlc/src && make docker-up && ./wgo_browser_sync.sh" 4
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
