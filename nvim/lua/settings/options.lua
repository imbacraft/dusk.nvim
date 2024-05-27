local options = {
	backup = false,                         -- creates a backup file
	clipboard = "unnamedplus",              -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	fileencoding = "utf-8",                 -- the encoding written to a file
	hlsearch = true,                        -- highlight all matches on previous search pattern
	ignorecase = true,                      -- ignore case in search patterns
	mouse = "a",                            -- allow the mouse to be used in neovim
	pumheight = 10,                         -- pop up menu height
	showmode = false,                       -- we don't need to see things like -- INSERT -- anymore
	showtabline = 0,                        -- Don't show tab line
	smartcase = true,                       -- smart case
	smartindent = false,                    -- disable smart indent because we enable indentation in treesitter
	splitbelow = true,                      -- force all horizontal splits to go below current window
	splitright = true,                      -- force all vertical splits to go to the right of current window
	swapfile = false,                       -- creates a swapfile
	termguicolors = true,                   -- set term gui colors (most terminals support this)
	timeoutlen = 250,                       -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true,                        -- enable persistent undo
	updatetime = 180,                       -- faster completion (4000ms default)
	writebackup = false,                    -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true,                       -- convert tabs to spaces
	shiftwidth = 2,                         -- the number of spaces inserted for each indentation
	tabstop = 2,                            -- insert 4 spaces for a tab
	cursorline = false,                     -- disable/enable highlight the current line
	number = true,                          -- show code lines
	relativenumber = false,                 -- relative numbered code lines
	numberwidth = 4,                        -- set number column width to 2 {default 4}
	signcolumn = "yes",                     -- always show the sign column, otherwise it would shift the text each time
	wrap = false,                           -- display lines as one long line
	sidescrolloff = 8,                      -- scrolloff = 8, -- is one of my fav
	spell = false,                          -- disable spell checking
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logiPat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"tar",
	"tarPlugin",
	"rrhelper",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tohmtl",
	"matchparen",
	"tutor_mode_plugin",
	"remote_plugins",
	"spellfile_plugin",
	"shada_plugin"
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Enable folding in markdown files
vim.g.markdown_folding = 1

--Disable Git Blame on startup
-- vim.g.gitblame_enabled = 0

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.opt.fillchars:append({ eob = " " })  -- hide tildes at the end of buffers
vim.opt.fillchars:append({ vert = " " }) -- hide borders of split vertical windows (e.g. nvim tree)

vim.opt.autochdir = true

vim.cmd("highlight EndOfBuffer ctermfg=NONE ctermbg=NONE guibg=NONE")          --requred to hide tildes at the end of buffer
vim.cmd("highlight VertSplit ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE") -- required to hide borders of split vertical windows

-- Disable native diagnostic lines because they are handled by the lsp_lines plugin
-- See https://git.sr.ht/~whynothugo/lsp_lines.nvim
vim.diagnostic.config({
	virtual_text = false
})

local M = {}

function M.toggle_option(option)
	local value = not vim.api.nvim_get_option_value(option, {})
	vim.opt[option] = value
	vim.notify(option .. " set to " .. tostring(value))
end

return M
