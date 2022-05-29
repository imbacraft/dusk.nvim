local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

null_ls.setup {
  debug = true,
  sources = {
    null_ls.builtins.formatting.google_java_format,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.formatting.rustfmt,
  },
}
