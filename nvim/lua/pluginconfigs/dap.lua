return {

  -- DAP
  { "mfussenegger/nvim-dap", lazy = true },

  -- Required to configure DAP for languages other than Java
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require('mason-nvim-dap').setup({
        ensure_installed = { 'chrome', 'node2', 'js', 'bash' },
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
          end,
          -- Debug client side Javascript/Typescript
          chrome = function(config)
            config.configurations = {
              {
                name = "Launch & Debug Chrome",
                type = "chrome",
                request = "launch",
                url = function()
                  local co = coroutine.running()
                  return coroutine.create(function()
                    vim.ui.input({
                      prompt = "Enter URL: ",
                      default = "http://localhost:4200",
                    }, function(url)
                      if url == nil or url == "" then
                        return
                      else
                        coroutine.resume(co, url)
                      end
                    end)
                  end)
                end,
                webRoot = "${workspaceFolder}",
                -- skip files from vite's hmr
                skipFiles = { "**/node_modules/**/*", "**/src/*" },
                port = 9222,
                protocol = "inspector",
                sourceMaps = true,
                -- userDataDir = false,
              },


            }

            require('mason-nvim-dap').default_setup(config) -- don't forget this!
          end,

          -- Debug server side Javascript/Typescript + single files
          node2 = function(config)
            config.configurations = {
              {
                name = 'Node2: Launch',
                type = 'node2',
                request = 'launch',
                -- program = '${file}', -- This doesn't work
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = 'inspector',
                console = 'integratedTerminal',
                outFiles = {
                  "${workspaceFolder}/**/*.js" -- This should be optional
                }
              },


            }
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
          end
        },
        -- automatic_installation = true,
      })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "LspAttach",
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "nvim-neotest/nvim-nio" },
      -- { "theHamsta/nvim-dap-virtual-text", opts = {} },
    },
    opts = {},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

}
