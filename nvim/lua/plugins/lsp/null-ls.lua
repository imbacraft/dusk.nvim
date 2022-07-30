local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.formatting.rustfmt,
  },
}
