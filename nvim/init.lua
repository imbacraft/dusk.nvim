-- disable netrw at the very start of the init.lua
-- Check https://github.com/nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--Load Vim Settings
require("settings.options")
require("settings.keymaps")
require("settings.autocommands")

-- Load and Configure plugins
require("lazy").setup({

	--------------------------------------
	-- UI --
	--------------------------------------

	-- Essential lua functions
	{ "nvim-lua/plenary.nvim",       lazy = true },
	-- Functions for buffer management
	{ 'ojroques/nvim-bufdel',        cmd = { "BufDel", "BufDelOthers" } },
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- Shows available keys
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("pluginconfigs.whichkey")
		end,
	},

	--Dashboard
	{
		"goolord/alpha-nvim",
		config = function()
			require("pluginconfigs.dashboard")
		end,
	},

	-- Status Line
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		opts = {
			options = {
				component_separators = "|",
				section_separators = "",
			},

			sections = {
				lualine_b = {
					"branch",
					"diff",
					{
						"diagnostics",
						sources = { "nvim_workspace_diagnostic" },
					},
				},
				lualine_c = { { "filename", path = 3 } },
			},
		},
	},

	-- Breadcrumbs
	{
		"LunarVim/breadcrumbs.nvim",
		event = "LspAttach",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("nvim-navic").setup {
						lsp = {
							auto_attach = true,
						},
					}
				end
			},
		},
		config = function()
			require("breadcrumbs").setup()
		end

	},

	--------------------------------------
	-- Colorschemes --
	--------------------------------------
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		lazy = true,
		event = "CursorHold",
	},

	{
		"nyoom-engineering/oxocarbon.nvim",
		lazy = true,
		event = "CursorHold",
	},

	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			vim.cmd.colorscheme("vscode")
		end,
	},

	--------------------------------------
	-- Optional Features --
	--------------------------------------

	-- Take a look at this file to see what features you need enabled
	{ import = "optional.optionalfeatures" },

	--------------------------------------
	-- File explorer and Finder --
	--------------------------------------

	-- Nvim Tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			-- Rename packages and imports also when renaming/moving files via nvim-tree.
			-- Currently works only for tsserver (used in Angular development)
			{
				"antosha417/nvim-lsp-file-operations",
				config = function()
					require("lsp-file-operations").setup()
				end,
			},
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				git = {
					enable = false,
				},
				update_focused_file = {
					enable = true,
					update_root = false,
				},
				view = {
					width = 50,
				},
			})
		end,
	},

	--Telescope Fuzzy Finder (files, commands, etc)
	{
		"nvim-telescope/telescope.nvim",
		-- lazy = true,
		-- cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"ahmedkhalf/project.nvim",
				config = function()
					require("project_nvim").setup({
						-- Methods of detecting the root directory. **"lsp"** uses the native neovim
						-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
						-- order matters: if one is not detected, the other is used as fallback. You
						-- can also delete or rearangne the detection methods.
						-- detection_methods = { "pattern", "lsp" },

						-- All the patterns used to detect root dir, when **"pattern"** is in
						-- detection_methods
						-- patterns = { ".git" },
					})
					require("telescope").load_extension("projects")
				end,
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					path_display = { "filename_first" },
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						previewer = false,
					},
					oldfiles = {
						theme = "dropdown",
						previewer = false,
					},
					live_grep = {
						theme = "ivy",
					},
					buffers = {
						theme = "dropdown",
						previewer = false,
					},
					recent_files = {
						theme = "dropdown",
						previewer = false,
					},
				},
			})
		end,
	},

	-- Search in file history
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { -- note how they're inverted to above example
			{
				"nvim-telescope/telescope.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
		},
		opts = {
			-- don't use `defaults = { }` here, do this in the main telescope spec
			extensions = {
				undo = {
					-- telescope-undo.nvim config, see below
				},
				-- no other extensions here, they can have their own spec too
			},
		},
		config = function(_, opts)
			-- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
			-- configs for us. We won't use data, as everything is in it's own namespace (telescope
			-- defaults, as well as each extension).
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},

	--------------------------------------
	-- LSP & Autocompletion --
	--------------------------------------
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		lazy = true,
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",

			-- Additional lua configuration, makes nvim stuff amazing!
			{ "folke/neodev.nvim",       opts = {} },
		},
	},

	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = true,
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				-- disable semanticTokens because they interfere with treesitter
				if client.supports_method("textDocument/semanticTokens") then
					client.server_capabilities.semanticTokensProvider = nil
				end
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({

				-- You can add more ensure installed servers based on the aliases on this list: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
				ensure_installed = {
					"jdtls",
					"tsserver",
					"lua_ls",
					"jsonls",
					"lemminx",
					"marksman",
					"emmet_ls",
					"gradle_ls",
					"html",
					"cssls",
					"bashls",
					"angularls",
				},
				handlers = {

					-- Don't setup jdtls here, it's configured in pluginconfigs/jdtls.lua
					jdtls = lsp_zero.noop,

					-- This is the default configuration for all servers except jdtls
					function(server_name)
						require("lspconfig")[server_name].setup({
							defaults = require("pluginconfigs.lsp").defaults(),
							capabilities = require("pluginconfigs.lsp").capabilities,
						})
					end,
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = { "InsertEnter", "CmdLineEnter" },
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",

			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"amarakon/nvim-cmp-buffer-lines",

			-- Adds a number of user-friendly snippets
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("pluginconfigs.cmp")
		end,
	},

	-- Improves LSP UI
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons",  -- optional
		},
		opts = {
			lightbulb = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
				folder_level = 6,
			},
			outline = {
				auto_preview = false,
				win_width = 50,
			},
		},
	},

	-- Shows signature as you type
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			hint_enable = false,
			cursorhold_update = false, -- Fixes errors from some LSP servers (ex. angularls)
			zindex = 45,            -- avoid overlap with nvim.cmp
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},

	-- Improves the way errors are shown in the buffer
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = "LspAttach",
		branch = "main",
		config = function()
			require("lsp_lines").setup({})
		end,
	},

	--LSP Diagnostics
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Trouble",
		opts = { auto_preview = false, focus = true }, -- automatically preview the location of the diagnostic
	},

	-- This plugin ensures that the necessary dependencies for Dusk.nvim get automatically installed
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({

				ensure_installed = {
					"bash-language-server",
					"google-java-format",
					"stylua",
					"shellcheck",
					"shfmt",
					"java-test",
					"java-debug-adapter",
					"markdown-toc",
					"sonarlint-language-server",
				},
				-- if set to true this will check each tool for updates. If updates
				-- are available the tool will be updated. This setting does not
				-- affect :MasonToolsUpdate or :MasonToolsInstall.
				-- Default: false
				auto_update = false,
				-- set a delay (in ms) before the installation starts. This is only
				-- effective if run_on_start is set to true.
				-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
				-- Default: 0
				start_delay = 3000, -- 3 second delay
			})
		end,
	},

	-- The Java LSP server
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
		config = function()
		end,
	},

	-- Rename packages and imports also when renaming/moving files via nvim-tree (for Java)
	{
		"simaxme/java.nvim",
		ft = "java",
		dependencies = { "mfussenegger/nvim-jdtls" },
		config = function()
			require("simaxme-java").setup({
				rename = {
					write_and_close = true -- automatically write and close modified (previously unopened) files after refactoring a java file
				},
			})
		end,
	},

	-- Sonarlint plugin
	{
		"https://gitlab.com/schrieveslaach/sonarlint.nvim",
		ft = { "java", "python", "cpp", "typescript", "typescriptreact", "html" },
		dependencies = { "mfussenegger/nvim-jdtls" },
		opts = {
			handlers = {},
		},
		config = function()
			require("sonarlint").setup({
				server = {
					-- root_dir = require("jdtls.setup").find_root({ "gradlew", ".git", "pom.xml", "mvnw" }),
					-- autostart = true,
					cmd = {
						"sonarlint-language-server",
						-- Ensure that sonarlint-language-server uses stdio channel
						"-stdio",
						"-analyzers",
						-- paths to the analyzers you need, using those for python and java in this example
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
						vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
					},
					settings = {
						sonarlint = {
							pathToCompileCommands = vim.fn.getcwd() .. "/compile_commands.json",
						},
					},
				},
				filetypes = {
					-- Tested and working
					"python",
					"cpp",
					"java",
					"typescript",
					"html",
				},
			})
		end,
	},


	--------------------------------------
	-- DAP - Debuggers  --
	--------------------------------------

	-- You can configure the DAP for your language there
	{ import = "pluginconfigs.dap" },


	--------------------------------------
	-- Linters and Formatters --
	--------------------------------------

	-- Custom Formatters
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = "LspAttach",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					java = { "google-java-format" },
				},
			})
		end,
	},

	-- -- NOTE: if you want additional linters, try this plugin
	-- -- Linters
	-- {
	--   "mfussenegger/nvim-lint",
	--   event = "LspAttach",
	--   config = function()
	--     local lint = require("lint")
	--
	--     lint.linters_by_ft = {
	--       -- javascript = { "eslint_d" },
	--       -- typescript = { "eslint_d" },
	--       -- javascriptreact = { "eslint_d" },
	--       -- typescriptreact = { "eslint_d" },
	--       java = { "checkstyle" },
	--     }
	--     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	--
	--     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	--       group = lint_augroup,
	--       callback = function()
	--         lint.try_lint()
	--       end,
	--     })
	--   end
	-- },

	--------------------------------------
	-- Git --
	--------------------------------------
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "CursorHold",
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { delay = 1200, virtual_text_pos = "eol" },
		},
	},

	{
		"akinsho/git-conflict.nvim",
		event = "CursorHold",
		config = function()
			require("git-conflict").setup()
		end,
	},

	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = { "DiffviewOpen", "DiffviewClose" },
	},

	{ "kdheepak/lazygit.nvim",   lazy = true,   cmd = "LazyGit" },

	--------------------------------------
	-- Editing Tools --
	--------------------------------------

	-- Syntax highliting
	{
		"nvim-treesitter/nvim-treesitter",
		event = "CursorHold",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"andymass/vim-matchup",
		},
		build = ":TSUpdate",
		config = function()
			require("pluginconfigs.treesitter")
		end,
	},

	-- Move blocks
	{
		"booperlv/nvim-gomove",
		event = "VeryLazy",
		opts = {
			handlers = {},
		},
	},

	-- Distraction free mode
	{
		"folke/zen-mode.nvim",
		dependencies = { "folke/twilight.nvim" },
		cmd = "ZenMode",
	},

	--Terminal
	{ "akinsho/toggleterm.nvim", version = "*", lazy = true,     cmd = "ToggleTerm", opts = {} },

	--Search & replace string
	{ "nvim-pack/nvim-spectre",  lazy = true,   cmd = "Spectre", opts = {} },

	-- Add/remove/change surrounding {}, (), "" etc
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- gcc to comment
	{
		"numToStr/Comment.nvim",
		event = "CursorHold",
		opts = {},
	},

	-- autoclose (), {} etc
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},

	-- autoclose tags
	{
		"windwp/nvim-ts-autotag",
		event = { "InsertEnter" },
		opts = {},
	},

	--------------------------------------
	-- Developer Tools --
	--------------------------------------

	-- Docker
	-- LazyDocker app is required https://github.com/mgierada/lazydocker.nvim?tab=readme-ov-file#-installation
	{
		"mgierada/lazydocker.nvim",
		cmd = "LazyDocker",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({})
		end,
	},

	-- Database Management
	{
		"tpope/vim-dadbod",
		cmd = { "DBUIToggle", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			require("pluginconfigs.dadbod").setup()
		end,
	},

	--------------------------------------
	-- Language specific --
	--------------------------------------

	--Markdown
	{ "dkarter/bullets.vim",           ft = "markdown" }, -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
	{ "jghauser/follow-md-links.nvim", ft = "markdown" }, --Follow md links with ENTER
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		-- install without yarn or npm
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}, {})

-- Always load jdtls setup autocommand
require("pluginconfigs.jdtls")
