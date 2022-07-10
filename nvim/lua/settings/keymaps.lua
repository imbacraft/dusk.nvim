local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<leader>w<Left>", "<C-w>h", opts)
keymap("n", "<leader>w<Up>", "<C-w>j", opts)
keymap("n", "<leader>w<Down>", "<C-w>k", opts)
keymap("n", "<leader>w<Right>", "<C-w>l", opts)
keymap("n", "<leader>ww", "<C-w>w", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<TAB>", ":bnext<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Custom
-- keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)

--Search for visually selected word
keymap("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], opts)

--ZenMode
keymap("n", "<C-z>", "<cmd>ZenMode<cr>", opts)

-- Open file under cursor with system app
keymap("n", "gx", [[:silent execute '!$BROWSER ' . shellescape(expand('<cWORD>'), 1)<CR>]], opts)
