local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
local map_callback = bind.map_callback

local plug_map = {

	-- LSP-related keymaps, work only when event = { "InsertEnter", "LspStart" }
	["n|<leader>l"] = map_cr("+Lsp"):with_noremap():with_silent():with_nowait():with_desc("LSP"),
	["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait():with_desc("lsp: Info"),
	["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait():with_desc("lsp: Restart"),

	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent():with_desc("Show doc"),
	["n|<leader>ca"] = map_cr("Lspsaga code_action"):with_noremap():with_silent():with_desc("Code action"),
	["n|gd"] = map_cr("Lspsaga peek_definition"):with_noremap():with_silent():with_desc("lsp: Preview definition"),
	["n|gD"] = map_cr("lua vim.lsp.buf.definition()<cr>"):with_noremap():with_silent():with_desc("lsp: Goto definition"),
	["n|gr"] = map_cr("Lspsaga lsp_finder"):with_noremap():with_silent():with_desc("lsp: Show references"),

    --Code keymaps
	["n|<leader>c"] = map_cr("+Code"):with_noremap():with_silent():with_desc("Code"),
	["v|ca"] = map_cu("Lspsaga code_action"):with_noremap():with_silent():with_desc("Code action for range"),
	["n|<leader>co"] = map_cr("Lspsaga outline"):with_noremap():with_silent():with_desc("Class Outline"),
	["n|<leader>cp"] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent():with_desc("lsp: Prev diagnostic"),
	["n|<leader>cn"] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent():with_desc("lsp: Next diagnostic"),
	["n|L"] = map_callback(function()
			vim.lsp.buf.signature_help()
		end)
		:with_noremap()
		:with_silent()
		:with_desc("lsp: Signature help"),
	["n|<leader>cR"] = map_cr("Lspsaga rename"):with_noremap():with_silent():with_desc("Rename in file range"),
	["n|<leader>cr"] = map_cr("Lspsaga rename ++project")
		:with_noremap()
		:with_silent()
		:with_desc("Rename in project range"),
	["n|<leader>ce"] = map_cr("<Cmd>Jaq<CR>")
		:with_noremap()
		:with_silent()
		:with_desc("Execute code"),

    --Java
    ["n|<leader>j"] = map_cr("+Java"):with_noremap():with_silent():with_desc("Java"),
    ["n|<leader>jt"] = map_cr("<Cmd>lua require'jdtls'.test_nearest_method()<CR>"):with_noremap():with_silent():with_desc("Test Method"),
    ["n|<leader>jT"] = map_cr("<Cmd>lua require'jdtls'.test_class()<CR>"):with_noremap():with_silent():with_desc("Test Class"),
    ["n|<leader>ju"] = map_cr("<Cmd>JdtUpdateConfig<CR>"):with_noremap():with_silent():with_desc("Update config"),

}

bind.nvim_load_mapping(plug_map)
