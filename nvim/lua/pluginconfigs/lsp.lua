-- Here is the default configuration for all LSPs except JDTLS
local config = {}

config.capabilities = vim.lsp.protocol.make_client_capabilities()

-- Make sure these capabilities exist on all servers
config.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

config.defaults = function()
  require("lspconfig").lua_ls.setup {
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    on_init = config.on_init,

    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  }
end

return config
