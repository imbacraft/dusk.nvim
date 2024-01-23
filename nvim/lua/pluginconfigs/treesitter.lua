require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { 'lua', 'java', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', "markdown", "markdown_inline" },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = false,
	-- Install languages synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- List of parsers to ignore installing
	ignore_install = {},
	-- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
	modules = {},
	highlight = { enable = true,
		disable = { "markdown" }, -- list of language that highlighting will be disabled
		additional_vim_regex_highlighting = true,

	},
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			scope_incremental = '<c-s>',
			node_decremental = '<M-space>',
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			},
		},
	}
}
