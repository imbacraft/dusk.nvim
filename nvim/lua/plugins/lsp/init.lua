local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("plugins.lsp.mason")
require("plugins.lsp.handlers").setup()
