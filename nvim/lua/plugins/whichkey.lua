local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = false, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	-- triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

---------------------------------
--NORMAL mode mappings
---------------------------------

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["d"] = { "<cmd>Alpha<cr>", "Dashboard" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
	["z"] = { "<cmd>ZenMode<cr>", "Zen" },

	a = {
		name = "Agenda",
		p = { "<Cmd>Todo<cr>", "Agenda for current project" },
		a = { "<Cmd>Todo g<cr>", "Global Agenda" },
		t = { "<Plug>BujoAddnormal", "Add new Task" },
		c = { "<Plug>BujoChecknormal<Cr>", "Check current Task" },
	},

	b = {
		name = "Buffer",
		p = { "<Cmd>bprevious<cr>", "Previous buffer" },
		n = { "<Cmd>bnext<cr>", "Next buffer" },
		k = { "<Cmd>Bdelete!<Cr>", "Kill current buffer" },
		K = { "<Cmd>BufOnly<CR>", "Kill all buffers except current" },
		b = { "<cmd>Telescope buffers<cr>", "Buffer List" },
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	t = {
		name = "Toggle",
		w = { '<cmd>lua require("plugins.functions").toggle_option("wrap")<cr>', "Wrap Text" },
		r = {
			'<cmd>lua require("plugins.functions").toggle_option("relativenumber")<cr>',
			"Relative Code Line Numbers",
		},
		a = { '<cmd>lua require("plugins.functions").toggle_option("number")<cr>', "Absolute Code Line Numbers" },
		h = { '<cmd>lua require("plugins.functions").toggle_option("cursorline")<cr>', "Cursor Line Highlight" },
		s = { '<cmd>lua require("plugins.functions").toggle_option("spell")<cr>', "Spell Check" },
		t = { "<cmd>term<cr>", "Terminal" },
		c = { "<cmd>let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>", "ConcealLevel" },
	},

	r = {
		name = "Replace",
		r = { "<cmd>lua require('spectre').open()<cr>", "Replace in path" },
		w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
		b = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace in the current Buffer" },
	},

	h = {
		name = "HTTP Request",
		r = { "<cmd>lua require('rest-nvim').run()<cr>", "Run request under cursor" },
		p = { "<cmd>lua require('rest-nvim').run(true)<cr>", "Preview the request cURL command" },
		l = { "<cmd>lua require('rest-nvim').last()<cr>", "Re-run last request" },
    e = { "<cmd>e test_request.http<CR>", "Open test request file"}
	},

	f = {
		name = "Find",
		c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
		f = {
			"<cmd>Telescope find_files hidden=true no_ignore=true<cr>",
			"Files",
		},
		p = { "<cmd>Telescope projects <CR>", "Projects" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	g = {
		name = "Git",
		n = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		p = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>GitBlameToggle<cr>", "Blame" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
		f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format Buffer" },
		i = { "<cmd>LspInstall<cr>", "Install LSP Server" },
		I = { "<cmd>LspInfo<cr>", "Installed LSP servers Info" },
		m = { "<cmd>Mason<cr>", "Mason LSP Installer Overview" },
		n = {
			"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
			"Next Diagnostic",
		},

		p = {
			"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable" },
		R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
	},

	o = {
		name = "Open",
		p = { "<Cmd>!open .<CR>", "Open current directory in OS file explorer" },
	},

	j = {
		name = "Java",
		o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
		t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Method (without Maven)" },
		T = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class (without Maven)" },
		u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
		r = { "<Cmd>Jaq<CR>", "Execute Java" },
	},

	m = {
		name = "Maven",
		c = { "<Cmd>T mvn compile<CR>", "Maven compile" },
		t = { "<Cmd>T mvn test<CR>", "Maven test" },
		p = { "<Cmd>T mvn package<CR>", "Maven package" },
		s = { "<Cmd>T mvn spring-boot:run<CR>", "Maven run Spring Boot application" },
		g = {
			"<Cmd>T mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4<CR>",
			"Create new standard Maven project",
		},
	},

	s = {
		name = "Search",
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "In current Buffer" },
		p = { "<cmd>Telescope live_grep theme=ivy<cr>", "In Project" },
		l = { "<cmd>Telescope resume<cr>", "Last Search" },
	},

	w = {
		name = "Window",
		w = { "<C-w>w", "Last window" },
		q = { "<cmd>q!<cr>", "Kill window" },
	},
}

---------------------------------
--VISUAL / INSERT mode mappings
---------------------------------
local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {}

which_key.setup(setup)
which_key.register(mappings, opts)
-- which_key.register(vmappings, vopts)
