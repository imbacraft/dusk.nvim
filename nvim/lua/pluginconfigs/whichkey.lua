local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

--------------------------------------
-- Custom Helper Functions --
--------------------------------------

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == '' then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ':h')
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
	if vim.v.shell_error ~= 0 then
		print 'Not a git repository. Searching on current working directory'
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require('telescope.builtin').live_grep {
			search_dirs = { git_root },
		}
	end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

local function telescope_live_grep_open_files()
	require('telescope.builtin').live_grep {
		grep_open_files = true,
		prompt_title = 'Live Grep in Open Files',
	}
end

-- Function to toggle diagnostic virtual text
local function ToggleVirtualText()
	local config = vim.diagnostic.config()
	local new_value = not config.virtual_text
	vim.diagnostic.config({ virtual_text = new_value })
	print("Virtual text " .. (new_value and "enabled" or "disabled"))
end

vim.api.nvim_create_user_command('ToggleVirtualText', ToggleVirtualText, {})

--------------------------------------
-- Keymaps --
--------------------------------------

local setup = {
	plugins = {
		marks = false,   -- shows a list of your marks on ' and `
		registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = false,  -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = false,  -- default bindings on <c-w>
			nav = false,      -- misc bindings to work with windows
			z = true,         -- bindings for folds, spelling and others prefixed with z
			g = true,        -- bindings for prefixed with g
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
		border = "none",        -- none, single, double, shadow
		position = "bottom",    -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 },                                        -- min and max height of the columns
		width = { min = 20, max = 50 },                                        -- min and max width of the columns
		spacing = 3,                                                           -- spacing between columns
		align = "center",                                                      -- align columns left, center or right
	},
	ignore_missing = true,                                                   -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", ":", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true,                                                        -- show help message on the command line when the popup is visible
	triggers = "auto",                                                       -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n",    -- NORMAL mode
	prefix = "<leader>",
	buffer = nil,  -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["a"] = { ":Alpha", "Dashboard" },
	["R"] = { ":%d+<cr>", "Remove All Text" },
	["y"] = { ":%y+<cr>", "Yank All Text" },
	["e"] = { ":NvimTreeToggle<cr>", "Tree Explorer" },
	["z"] = { ":ZenMode<cr>", "Zen Mode" },

	b = {
		name = "Buffer",
		p = { "<Cmd>bprevious<cr>", "Previous buffer" },
		n = { "<Cmd>bnext<cr>", "Next buffer" },
		k = { "<Cmd>BufferClose<Cr>", "Close current buffer" },
		K = { "<cmd>BufferCloseAllButCurrent<cr>", "Close all buffers except current" },
		b = { "<cmd>Telescope buffers theme=dropdown<cr>", "Buffer List" },
		r = { "<cmd>BufferCloseBuffersRight<cr>", "Close Buffers to the right" },
		l = { "<cmd>BufferCloseBuffersLeft<cr>", "Close Buffers to the left" },
	},

	D = {
		name = "Database",
		t = { "<cmd>DBUIToggle<cr>", "Toggle UI" },
		b = { "<cmd>DBUIFindBuffer<cr>", "Find Buffer" },
		r = { "<cmd>DBUIRenameBuffer<cr>", "Rename Buffer" },
		i = { "<cmd>DBUILastQueryInfo<cr>", "Last Query Info" },
	},

	p = {
		name = "Package Manager",
		x = { ":Lazy clean<cr>", "Clean" },
		C = { ":Lazy check<cr>", "Check" },
		d = { ":Lazy debug<cr>", "Debug" },
		i = { ":Lazy install<cr>", "Install" },
		s = { ":Lazy sync<cr>", "Sync" },
		l = { ":Lazy log<cr>", "Log" },
		h = { ":Lazy home<cr>", "Home" },
		H = { ":Lazy help<cr>", "Help" },
		p = { ":Lazy profile<cr>", "Profile" },
		u = { ":Lazy update<cr>", "Update" },
	},

	f = {
		name = "Find",
		a = { ":Telescope autocommands<cr>", "Autocommmands" },
		c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" },
		f = {
			"<cmd>Telescope find_files hidden=true <cr>",
			"Files",
		},
		p = { "<cmd>Telescope projects <CR>", "Projects" },
		b = { "<cmd>Telescope buffers<cr>", "Buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "Help" },
		r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
	},

	c = {
		name = "Code",
		a = { ":lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		e = { ":Jaq<cr>", "Execute Code" },
		x = { ":Trouble diagnostics toggle focus = true<cr>", "Workspace Diagnostics" },
		X = { ":Trouble diagnostics toggle filter.buf=0 focus = true<cr>", "Current buffer Diagnostics" },
		R = { ":Lspsaga rename ++project<cr>", "Rename in Project" },
		r = { ":Lspsaga rename<cr>", "Rename in current buffer" },
		o = { ":Lspsaga outline<cr>", "Code Outline" },
		f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
		n = {
			":Lspsaga diagnostic_jump_next<cr>",
			"Next Diagnostic",
		},
		p = {
			":Lspsaga diagnostic_jump_prev<cr>",
			"Prev Diagnostic",
		},
		q = { ":Trouble quickfix focus = true<cr>", "Diagnostics Quickfix" },

	},

	r = {
		name = "Replace",
		r = { "<cmd>lua require('spectre').open()<cr>", "Replace in path" },
		w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
		b = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace in the current Buffer" },
	},

	j = {
		name = "Java",
		o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
		t = {
			"<Cmd>lua require'jdtls'.test_nearest_method({ config = { console = 'console' }})<CR>",
			"Test Method",
		},
		T = {
			"<Cmd>lua require'jdtls'.test_class({ config = { console = 'console' }})<CR>",
			"Test Class",
		},
		f = { "<cmd>lua require('conform').format({async = true})<cr>", "Format with Google Java Format" },
		R = { "<cmd>JdtWipeDataAndRestart<cr>", "Wipe project data and Restart server" },
		v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
		c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
		u = { "<Cmd>lua require('jdtls').update_project_config()<CR>", "Refresh java config" },
		e = { "<Cmd>JdtSetRuntime<CR>", "Choose Java Runtime" },
		C = { "<Cmd>JdtCompile<CR>", "Compile Java" },
		d = {
			":lua require('jdtls').setup_dap({ hotcodereplace = 'auto' })<cr>; :lua require'jdtls.dap'.setup_dap_main_class_configs()<cr>",
			"Refresh DAP Debugger",
		},
	},


	s = {
		name = "Search String",
		b = { function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, "In current buffer" },
		p = { "<cmd>LiveGrepGitRoot<cr>", "In Git root (Project)" },
		c = { "<cmd>Telescope live_grep theme=ivy<cr>", "In current working directory" },
		r = { "<cmd>Telescope resume<cr>", "Resume last Search" },
		o = { telescope_live_grep_open_files, "In currently open files" },
		u = { "<cmd>Telescope undo<cr>", "In File History" }
	},

	g = {
		name = "Git",
		g = { ":LazyGit<cr>", "Lazygit" },
		-- G = { ":Git<cr>", "Git Fugitive" },
		n = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		p = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		P = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			":lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { ":Telescope git_status<cr>", "Open changed file" },
		b = { ":Telescope git_branches<cr>", "Checkout branch" },
		c = { ":Telescope git_commits<cr>", "Checkout commit" },
		d = {
			":DiffviewOpen<cr>",
			"Open Diff",
		},
		D = {
			":DiffviewClose<cr>",
			"Close Diff",
		},
	},

	l = {
		name = "LSP - Language",
		f = { ":lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
		i = { ":LspInfo<cr>", "Info" },
		m = { ":Mason<cr>", "Install Language" },
		w = {
			name = "LSP Workspace",
			l = { function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List Workspace Folders" }
		},
	},

	d = {
		name = "Debug",
		c = { ":lua require'dap'.continue()<cr>", "Start/Continue" },
		o = { ":lua require'dap'.step_over()<cr>", "Step Over" },
		i = { ":lua require'dap'.step_into()<cr>", "Step Into" },
		u = { ":lua require'dap'.step_out()<cr>", "Step Out" },
		b = { ":lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
		r = { ":lua require'dap'.repl.open()<cr>", "Repl Console" },
		d = { ":lua require'dapui'.toggle()<cr>", "Dap UI" },
		t = { ":lua require'dap'.terminate()<cr>", "Terminate session" },
	},

	o = {
		name = "Open",
		f = { ":ToggleTerm direction=float<cr>", "Float Terminal" },
		t = { ":ToggleTerm size=16 direction=horizontal<cr>", "Horizontal Terminal" },
		v = { ":ToggleTerm size=50 direction=vertical<cr>", "Vertical Terminal" },
	},

	t = {
		name = "Toggle option",
		s = { '<cmd>ASToggle<cr>', "Toggle Autosave" },
		l = { '<cmd>lua require("lsp_lines").toggle()<cr>', "Toggle Lsp_Lines plugin" },
		w = { '<cmd>lua require("settings.options").toggle_option("wrap")<cr>', "Wrap Text" },
		r = {
			'<cmd>lua require("settings.options").toggle_option("relativenumber")<cr>',
			"Relative Code Line Numbers",
		},
		a = {
			'<cmd>lua require("settings.options").toggle_option("number")<cr>',
			"Absolute Code Line Numbers",
		},
		c = { "<cmd>let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <CR>", "ConcealLevel" },
		v = { '<cmd>ToggleVirtualText<cr>', "Toggle Diagnostic Virtual Lines" },
	},

	C = {
		name = "Containers - Docker",
		d = { "<cmd>LazyDocker<cr>", "Run LazyDocker" },
	},

	w = {
		name = "Window",
		w = { "<C-w>w", "Last window" },
		q = { "<cmd>q!<cr>", "Kill window" },
	},

	m = {
		name = "Markdown",
		p = { ":MarkdownPreview<CR>", "Preview in browser" },
		s = { ":MarkdownPreviewStop<CR>", "Stop Preview" },
	},
}


which_key.setup(setup)
which_key.register(mappings, opts)
