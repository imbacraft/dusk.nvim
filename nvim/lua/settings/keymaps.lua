local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

--Doom emacs keymap for find file
keymap("n", "<leader><Space>", "<cmd>Telescope find_files hidden=true <cr>", opts)

-- Better window navigation
keymap("n", "<leader>w<Left>", "<C-w>h", opts)
keymap("n", "<leader>w<Up>", "<C-w>j", opts)
keymap("n", "<leader>w<Down>", "<C-w>k", opts)
keymap("n", "<leader>w<Right>", "<C-w>l", opts)
keymap("n", "<leader>ww", "<C-w>w", opts)

-- Navigate buffers
-- keymap("n", "<TAB>", ":bnext<CR>", opts)
-- keymap("n", "<S-TAB>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Close Windows quickly with shift+Q
keymap("n", "Q", ":only<CR>", opts)

--Search for visually selected word
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)

-- Open file under cursor with system app
keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cWORD>'), 1)<CR>]], opts)

-- ESC to clear highlights after search
keymap("n", "<Esc>", ":noh<CR> :helpclose<CR>", opts)

--LSP basic keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local lspopts = { buffer = true }
      vim.keymap.set(mode, lhs, rhs, lspopts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>Lspsaga hover_doc<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>Lspsaga peek_definition<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>Lspsaga finder imp<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references
    -- bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gr', '<cmd>Lspsaga finder<cr>')

    -- Displays a function's signature information
    bufmap('n', 'L', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- Move to the previous diagnostic
    bufmap('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

    -- Move to the next diagnostic
    bufmap('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})


-- Adds custom keymaps from nvim-jdtls plugin
local function add_jdtls_keymaps()

  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
  )
  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
  )
  vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
  vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
  vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
  vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local vopts = {
    mode = "v",     -- VISUAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local vmappings = {
    J = {
      name = "Java",
      v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
      c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
      m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
    },
  }

  which_key.register(vmappings, vopts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'java' },
  desc = 'Adds keymaps custom to nvim-jdtls plugin',
  callback = add_jdtls_keymaps,
})

