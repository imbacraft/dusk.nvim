local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  -- conceallevel = 2,                        -- so that `` is NOT visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 1,                         -- Don't show tab line
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 400,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  tabstop = 4,                             -- insert 4 spaces for a tab
  cursorline = true,                      -- disable highlight the current line
  number = true,                           -- show code lines
  relativenumber = false,                  -- set relative numbered code lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- is one of my fav
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  spell = false,                           -- disable spell checking

}

for k, v in pairs(options) do
  vim.opt[k] = v
end

local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  -- "netrw",  -- If you disable netrw, you can't use gx to open links in browser
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
  "tohmtl"

}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Enable folding in markdown files
vim.g.markdown_folding = 1

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.opt.fillchars:append { eob = " " } -- hide tildes at the end of buffers
vim.opt.fillchars:append { vert = " "} -- hide borders of split vertical windows (e.g. nvim tree)

vim.cmd "highlight EndOfBuffer ctermfg=NONE ctermbg=NONE guibg=NONE" --requred to hide tildes at the end of buffer
vim.cmd "highlight VertSplit ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE" -- required to hide borders of split vertical windows

vim.cmd"let g:bujo#window_width = 65" --Increase width of Bujo plugin window
