--Hide status line and tabline while on Dashboard screen
-- set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd([[
      set laststatus=1 | autocmd BufUnload <buffer> set laststatus=3
    ]])
	end,
})

--Close specific windows with q
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf",
	"help",
	"man",
	"lspinfo",
	"spectre_panel",
	"startuptime",
	"notify",
	"nofile",
	"lspinfo",
	"terminal",
	"prompt",
	"toggleterm",
	"copilot",
	"startuptime",
	"tsplayground",
	"PlenaryTestPopup",
	"fugitive",
	"dap-repl",
	"Jaq", },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

--Set conceallevel and wrap for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown", "md" },
	callback = function()
		vim.cmd([[
      set conceallevel=2
      set wrap
      set foldlevel=99
    ]])
	end,
})

--Don't autostart new comment line after a comment
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
