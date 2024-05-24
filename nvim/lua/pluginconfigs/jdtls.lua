-- Configure nvim-jdtls specific keymaps and functionality
local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })

local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local jdtls_settings = {

  capabilities = {
    workspace = {
      configuration = true
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },

  settings = {
    java = {
      references = {
        includeDecompiledSources = true,
      },
      configuration = {
        runtimes = {
          -- {
          --   name = "JavaSE-17",
          --   path = "/usr/lib/jvm/java-17-openjdk-amd64/bin/java",
          --   default = true,
          -- }
        }
      }
    }
  },

  init_options = {
    extendedClientCapabilities = extendedClientCapabilities
  }


}





local function jdtls_setup()
  require("jdtls.setup").add_commands()

  -- NOTE: Java specific keymaps with which key
  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
  )
  vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
  )
  vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
  vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
  vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
  vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end

  local vopts = {
    mode = "v",     -- VISUAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
  }

  local vmappings = {
    J = {
      name = "Java",
      v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
      c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
      m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
    },
  }

  which_key.register(vmappings, vopts)
end

vim.api.nvim_create_autocmd('FileType', {
  group = java_cmds,
  pattern = { 'java' },
  desc = 'Setup jdtls',
  callback = jdtls_setup,
})


return jdtls_settings
