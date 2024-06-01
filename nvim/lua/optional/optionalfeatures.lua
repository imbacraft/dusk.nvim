return {

	-- Autosave feature
	{
		"okuuva/auto-save.nvim",
		cmd = "ASToggle", -- Use this cmd if you want to enable or Space + t + s
		opts = {
			execution_message = {
				enabled = false,
			},
			debounce_delay = 5000,
		},
	},

	-- Lsp server status updates
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {},
	},

	-- Electric indentation
	{
		"nmac427/guess-indent.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		opts = {},
	},

	-- Highlight word under cursor
	{
		"RRethy/vim-illuminate",
		event = "VeryLazy",
		config = function()
			local illuminate = require("illuminate")
			vim.g.Illuminate_ftblacklist = { "NvimTree" }

			illuminate.configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				delay = 200,
				filetypes_denylist = {
					"dirvish",
					"fugitive",
					"alpha",
					"NvimTree",
					"packer",
					"neogitstatus",
					"Trouble",
					"lir",
					"Outline",
					"spectre_panel",
					"toggleterm",
					"DressingSelect",
					"TelescopePrompt",
					"sagafinder",
					"sagacallhierarchy",
					"sagaincomingcalls",
					"sagapeekdefinition",
				},
				filetypes_allowlist = {},
				modes_denylist = {},
				modes_allowlist = {},
				providers_regex_syntax_denylist = {},
				providers_regex_syntax_allowlist = {},
				under_cursor = true,
			})
		end,
	},

	-- Delete whitespaces automatically on save
	-- {
	-- 	"saccarosium/nvim-whitespaces",
	-- 	event = "BufWritePre",
	-- 	opts = {
	-- 		handlers = {},
	-- 	},
	-- },

	{
		"NStefan002/visual-surround.nvim",
		event = "VeryLazy",
		config = function()
			require("visual-surround").setup({
				-- your config
			})
		end,
	},

	-- Session management
	-- auto save and restore the last session
	-- {
	-- 	"olimorris/persisted.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("persisted").setup({
	-- 			ignored_dirs = {
	-- 				"~/.config",
	-- 				"~/.local/nvim",
	-- 				{ "/",    exact = true },
	-- 				{ "/tmp", exact = true },
	-- 			},
	-- 			autoload = true,
	-- 			on_autoload_no_session = function()
	-- 				vim.notify("No existing session to load.")
	-- 			end,
	-- 		})
	-- 	end,
	-- },


	-- Tmux Integration
	-- {
	-- 	"alexghergh/nvim-tmux-navigation",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("nvim-tmux-navigation").setup({
	-- 			disable_when_zoomed = true, -- defaults to false
	-- 		})
	-- 	end,
	-- },
}
