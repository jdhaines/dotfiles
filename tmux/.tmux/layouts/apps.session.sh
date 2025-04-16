# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/git"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "apps"; then

  # Create a new window inline within session layout definition.
  #new_window "misc"

  # Load a defined window layout.
  load_window "HealthAndVitality"
  # load_window "Saferra"
  load_window "Docs"
  # load_window "SoftwareDocs"
  # load_window "EngineeringDocs"
  load_window "JoshHaines"
  load_window "SFPlatform"
  # load_window "Codewars"
  load_window "SAF"
  load_window "Mesra"

  # Select the default active window on session creation.
  select_window 6

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
