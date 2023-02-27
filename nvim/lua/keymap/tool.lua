local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
require("keymap.helpers")

local plug_map = {
	-- Git plugins
	["n|gps"] = map_cr("G push"):with_noremap():with_silent():with_desc("git: Push"),
	["n|gpl"] = map_cr("G pull"):with_noremap():with_silent():with_desc("git: Pull"),
	["n|<leader>G"] = map_cu("Git"):with_noremap():with_silent():with_desc("Git-fugitive"),
	["n|<leader>g"] = map_callback(function()
			_toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),
	["t|<leader>g"] = map_callback(function()
			_toggle_lazygit()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("git: Toggle lazygit"),



	-- Plugin: nvim-tree
	["n|<leader>e"] = map_cr("NvimTreeToggle"):with_noremap():with_silent():with_desc("filetree: Toggle"),

	-- Plugin: toggleterm
	["t|<Esc><Esc>"] = map_cmd([[<C-\><C-n>]]):with_silent(), -- switch to normal mode in terminal.
	["t|jk"] = map_cmd([[<C-\><C-n>]]):with_silent(), -- switch to normal mode in terminal.
	["n|<leader>ot"] = map_cr([[execute v:count . "ToggleTerm direction=horizontal"]])
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle horizontal"),
	["n|<leader>ov"] = map_cr([[execute v:count . "ToggleTerm direction=vertical"]])
		:with_noremap()
		:with_silent()
		:with_desc("terminal: Toggle vertical"),

	-- Plugin: trouble
	["n|<leader>cx"] = map_cr("TroubleToggle"):with_noremap():with_silent():with_desc("lsp: Toggle trouble list"),

	-- Plugin: telescope
	["n|<leader>f"] = map_cr("+Find"):with_noremap():with_silent():with_desc("Find"),
	["n|<leader>fk"] = map_callback(function()
			_command_panel()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Keymaps"),
	["n|<leader>fp"] = map_callback(function()
			require("telescope").extensions.projects.projects({})
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: Project"),
	["n|<leader>fr"] = map_callback(function()
			require("telescope").extensions.frecency.frecency()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File by frecency"),
	["n|<leader>sp"] = map_callback(function()
			require("telescope").extensions.live_grep_args.live_grep_args()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("String in project"),
	["n|<leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent():with_desc("find: File in project"),
	["n|<leader>fc"] = map_cu("Telescope colorscheme")
		:with_noremap()
		:with_silent()
		:with_desc("ui: Change colorscheme for current session"),
	["n|<leader>fg"] = map_cu("Telescope git_files")
		:with_noremap()
		:with_silent()
		:with_desc("find: file in git project"),
	["n|<leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffers"),
	["n|<leader>bb"] = map_cu("Telescope buffers"):with_noremap():with_silent():with_desc("find: Buffers"),
	["n|<leader>sw"] = map_cu("Telescope grep_string"):with_noremap():with_silent():with_desc("find: Current word"),

	-- Plugin: dap
	["n|<F6>"] = map_callback(function()
			require("dap").continue()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run/Continue"),
	["n|<F7>"] = map_callback(function()
			require("dap").terminate()
			require("dapui").close()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Stop"),
	["n|<F8>"] = map_callback(function()
			require("dap").toggle_breakpoint()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Toggle breakpoint"),
	["n|<F9>"] = map_callback(function()
			require("dap").step_into()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step into"),
	["n|<F10>"] = map_callback(function()
			require("dap").step_out()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step out"),
	["n|<F11>"] = map_callback(function()
			require("dap").step_over()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Step over"),
	["n|<leader>db"] = map_callback(function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Set breakpoint with condition"),
	["n|<leader>dc"] = map_callback(function()
			require("dap").run_to_cursor()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run to cursor"),
	["n|<leader>dl"] = map_callback(function()
			require("dap").run_last()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Run last"),
	["n|<leader>do"] = map_callback(function()
			require("dap").repl.open()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("debug: Open REPL"),
}

bind.nvim_load_mapping(plug_map)
