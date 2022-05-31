local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

--Ensure compilers for treesitter are installed
require 'nvim-treesitter.install'.compilers = { "zig", "clang", "gcc" }

configs.setup {
  ensure_installed = {"java", "lua", "html"},
  sync_install = false,
  -- NOTE: need to ignore installation of phpdoc parser because it is not ready for Mac m1 arm64 architecture
  ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
  autopairs = { enable = true },
  autotag = {enable = true},
  highlight = {
    enable = true,
    -- disable = { "css", "markdown" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true }
}
