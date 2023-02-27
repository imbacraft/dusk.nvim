local ui = {}

ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	config = require("ui.alpha"),
}
ui["akinsho/bufferline.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.bufferline"),
}
ui["catppuccin/nvim"] = {
	lazy = true,
	name = "catppuccin",
	config = require("ui.catppuccin"),
}
-- ui["sainnhe/edge"] = {
-- 	lazy = true,
-- 	config = require("ui.edge"),
-- }
ui["j-hui/fidget.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.gitsigns"),
}
ui["nvim-lualine/lualine.nvim"] = {
	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.lualine"),
}
ui["karb94/neoscroll.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("ui.neoscroll"),
}

ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}

return ui
