--Load Plugins
require "plugins"

--Load Vim Settings
require "settings.options"
require "settings.keymaps"
require "settings.colorscheme"
require "settings.autocommands"
require "settings.duskline"

-- These plugin settings are loaded on startup
-- The rest not mentioned here are loaded when the plugin is loaded.
require "plugins.dashboard"
require "plugins.whichkey"
require "plugins.treesitter"
