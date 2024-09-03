-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

----
-- This is where you actually apply your config choices
----

-- appearance
config.color_scheme = "catppuccin-macchiato"
config.window_background_opacity = 0.90
config.window_decorations = "NONE"
config.enable_tab_bar = false

-- fonts
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
-- config.font = wezterm.font("MonoLisa Nerd Font Mono")
config.font_size = 13
-- config.freetype_load_flags = "NO_HINTING"
-- config.line_height = 1.2

-- spawn a fish shell in login mode
-- config.default_prog = { "/usr/bin/fish", "-l" }
-- config.default_prog = { "/usr/bin/fish" }

return config
