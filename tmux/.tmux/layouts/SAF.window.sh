# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/git/saf/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "SAF"

# Split window into panes.
split_v 10
split_h 25
split_h 25

# Run commands.
run_cmd "cd ~/git/saf && nvim ." 1
run_cmd "cd ~/git/saf/" 2
run_cmd "cd ~/git/saf/src/backend" 3
run_cmd "cd ~/git/saf/src/frontend" 4

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
