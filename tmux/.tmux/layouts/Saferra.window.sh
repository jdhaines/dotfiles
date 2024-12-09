# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/git/saferra/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "Saferra"

# Split window into panes.
split_v 10
split_h 66
split_h 66
split_h 50

# Run commands.
run_cmd "cd ~/git/saferra && nvim ." 1
run_cmd "cd ~/git/saferra" 2
run_cmd "cd ~/git/saferra && make run-client" 3
run_cmd "cd ~/git/saferra && make run-server" 4
run_cmd "cd ~/git/saferra && make templ & make tailwind &" 5
# run_cmd "echo \"hi\"" 6
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
select_pane 1
