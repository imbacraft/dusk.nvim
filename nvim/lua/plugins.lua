local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Performance
pcall(require, "impatient") -- Call impatient plugin before all others to improve performance. Keep this line here.

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	---------------------
	-- Package Manager --
	---------------------
	use("wbthomason/packer.nvim") -- Packer manage itself

	----------------------
	-- Required plugins --
	----------------------
	-- Improve startup time (source: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236)
	use("lewis6991/impatient.nvim")
	use("nvim-lua/plenary.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("nvim-lua/popup.nvim")

	----------------------
	-- General --
	----------------------

	-- Key Navigator
	use("folke/which-key.nvim")

	-- Measure nvim startup time
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	--Replace native matchparen.vim with a lua alternative for performance
	use({
		"monkoose/matchparen.nvim",
		config = function()
			require("matchparen").setup()
		end,
	})

	--Auto save
	use({
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({
				debounce_delay = 1500, -- saves the file at most every `debounce_delay` milliseconds
			})
		end,
	})

	--Smooth scrolling
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})

	--Automatically create any non-existent directories before writing the buffer.
	use({ "jghauser/mkdir.nvim" })
	-----------------------------------------------
	-- Themes, Icons, Tree, Statusbar, Bufferbar --
	-----------------------------------------------

	-- Colorschemes
	use("RRethy/nvim-base16")
	use("NTBBloodbath/doom-one.nvim")
	use("LunarVim/Colorschemes")
	use("EdenEast/nightfox.nvim")
	use("B4mbus/oxocarbon-lua.nvim")

	-- Buffer (Tab) line
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	-- Status Line
	use("nvim-lualine/lualine.nvim")

	--Dashboard
	use("goolord/alpha-nvim")

	--------------------------------------
	-- File Navigation and Fuzzy Search --
	--------------------------------------

	-- Nvim Tree
	use({ "kyazdani42/nvim-tree.lua" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })

	-- Find projects
	use("ahmedkhalf/project.nvim")

	--------------------------------------
	-- Autocompletion --
	--------------------------------------
	use("hrsh7th/nvim-cmp") -- Completion (cmp) plugin
	use("hrsh7th/cmp-buffer") -- Cmp source for buffer words
	use("hrsh7th/cmp-path") -- Cmp source for path
	use("hrsh7th/cmp-nvim-lsp") -- Cmp source for LSP client
	use("hrsh7th/cmp-nvim-lua") -- Cmp source for nvim lua
	use("saadparwaiz1/cmp_luasnip") -- Luasnip completion source

	-- Snippets
	use("L3MON4D3/LuaSnip") -- Snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	--------------------------------------
	-- LSP --
	--------------------------------------
	--  Copilot
	use({
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	})

	-- LSP
	use("neovim/nvim-lspconfig") -- Enable native LSP
	use("williamboman/mason.nvim") -- New LSP Installer
	use("williamboman/mason-lspconfig.nvim") -- New LSP server Installer
	use("tamago324/nlsp-settings.nvim") -- Configure LSP settings with json

	-- Java LSP
	use({ "mfussenegger/nvim-jdtls" })

	-- Code Runner
	use({ "is0n/jaq-nvim" })

	--  Formatters
	use("jose-elias-alvarez/null-ls.nvim") -- Inject LSP diagnostics, code actions, formatters ...

	--LSP diagnostics
	use({
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	})

	--------------------------------------
	-- Features --
	--------------------------------------

	--Terminal
	use({ "kassio/neoterm", cmd = "T" }) --Send shell commands to new buffer-terminal.

	--Testing
	use({ "vim-test/vim-test", cmd = { "TestFile", "TestNearest", "TestSuite", "TestVisit" } })

	--REST API requests
	use({
		"NTBBloodbath/rest.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	--------------------------------------
	-- Editing Enhancements --
	--------------------------------------

	--Show colors
	use({ "norcalli/nvim-colorizer.lua" })

	--Replace with sed cmd
	use({
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	})

	--Text align
	use("Vonr/align.nvim")

	--Handy package with many lightweight editing tools. Choose those that fit you.
	-- Check documentation at https://github.com/echasnovski/mini.nvim
	use({
		"echasnovski/mini.nvim",
		config = function()
			require("mini.pairs").setup()
			require("mini.comment").setup()
			require("mini.jump").setup()
			require("mini.jump2d").setup()
			require("mini.surround").setup()
			require("mini.fuzzy").setup()
		end,
	})

	--------------------------------------
	-- File type specific --
	--------------------------------------

	--Markdown
	use({ "dkarter/bullets.vim", ft = "markdown" }) -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	}) --Markdown preview
	use({ "jghauser/follow-md-links.nvim", ft = "markdown" }) --Follow md links with ENTER
	use({ "vuciv/vim-bujo" }) --Handy Global and Project Agendas

	--Csv
	use({ "mechatroner/rainbow_csv", ft = "csv" })

	--------------------------------------
	-- Git --
	--------------------------------------
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({ "f-person/git-blame.nvim" })

	use({
		"akinsho/git-conflict.nvim",
		tag = "*",
		config = function()
			require("git-conflict").setup()
		end,
	})

	use({ "kdheepak/lazygit.nvim", cmd = "LazyGit" })
	--------------------------------------
	-- DAP (Required to run unit tests)--
	--------------------------------------
	use({ "mfussenegger/nvim-dap" })
	use({ "Pocco81/DAPInstall.nvim" })

	-----------------------------------
	-- Treesitter --
	-----------------------------------

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Syntax highlighting
	use("nvim-treesitter/nvim-treesitter-textobjects") -- Extra text objects for better selecting
	use({ "windwp/nvim-ts-autotag" }) -- Auto close tags
	-- use({ "windwp/nvim-autopairs" }) -- Autoclose quotes, parentheses etc.

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
