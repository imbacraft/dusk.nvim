local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

local cmp_status_ok, cmp = pcall(require, "cmp_nvim_lsp")
if not cmp_status_ok then
  return
end

require("plugins.lsp.mason")
require("plugins.lsp.handlers").setup()
