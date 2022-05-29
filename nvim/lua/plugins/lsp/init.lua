local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "plugins.lsp.lsp-installer" -- Something in lsp-installer file causes the "expected a table, got boolean" exception
require("plugins.lsp.handlers").setup()
require "plugins.lsp.null-ls"
