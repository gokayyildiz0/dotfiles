-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.macos_window_background_blur = 30

-- Fix scrolling behavior by enabling scrollback buffer
config.scrollback_lines = 5000 -- Allow up to 5000 lines of scrollback

-- Optional: Enable scrollbar
config.enable_scroll_bar = true

-- and finally, return the configuration to wezterm
return config
