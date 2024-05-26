--- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

--Load Vim Settings
require "settings.options"
require "settings.keymaps"
require "settings.autocommands"

-- Load and Configure plugins
require('lazy').setup({

  --------------------------------------
  -- UI --
  --------------------------------------

  { 'nvim-lua/plenary.nvim',       lazy = true },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'folke/which-key.nvim',
    lazy = false,
    config = function()
      require("pluginconfigs.whichkey")
    end
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    lazy = true,
    event = "CursorHold"
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = true,
    event = "CursorHold"
  },

  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    config = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },

  {
    'nmac427/guess-indent.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {}
  },

  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    event = "VeryLazy",
  },

  {
    "tris203/hawtkeys.nvim",
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "gen740/SmoothCursor.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      local default = {
        autostart = true,
        cursor = "", -- cursor shape (need nerd font)
        intervals = 35, -- tick interval
        linehl = nil, -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
        type = "exp", -- define cursor movement calculate function, "default" or "exp" (exponential).
        fancy = {
          enable = true, -- enable fancy mode
          head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
          body = {
            { cursor = "", texthl = "SmoothCursorRed" },
            { cursor = "", texthl = "SmoothCursorOrange" },
            { cursor = "●", texthl = "SmoothCursorYellow" },
            { cursor = "●", texthl = "SmoothCursorGreen" },
            { cursor = "•", texthl = "SmoothCursorAqua" },
            { cursor = ".", texthl = "SmoothCursorBlue" },
            { cursor = ".", texthl = "SmoothCursorPurple" },
          },
          tail = { cursor = nil, texthl = "SmoothCursor" },
        },
        priority = 10, -- set marker priority
        speed = 25, -- max is 100 to stick to your current position
        texthl = "SmoothCursor", -- highlight group, default is { bg = nil, fg = "#FFD400" }
        threshold = 3,
        timeout = 3000,
        disable_float_win = true, -- disable on float window
      }
      require("smoothcursor").setup(default)
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = function()
      local illuminate = require("illuminate")
      vim.g.Illuminate_ftblacklist = { "NvimTree" }

      illuminate.configure({
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        delay = 200,
        filetypes_denylist = {
          "dirvish",
          "fugitive",
          "alpha",
          "NvimTree",
          "packer",
          "neogitstatus",
          "Trouble",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "TelescopePrompt",
          "sagafinder",
          "sagacallhierarchy",
          "sagaincomingcalls",
          "sagapeekdefinition",
        },
        filetypes_allowlist = {},
        modes_denylist = {},
        modes_allowlist = {},
        providers_regex_syntax_denylist = {},
        providers_regex_syntax_allowlist = {},
        under_cursor = true,
      })
    end,
  },

  {
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    event = "VeryLazy",
    opts = {
      handlers = {},
    },
    config = function()
      require("pqf").setup()
    end,
  },

  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    config = function()
      require("precognition").setup({
        startVisible = true,
        showBlankVirtLine = false,
        -- highlightColor = { link = "Comment"),
        -- hints = {
        --      Caret = { text = "^", prio = 2 },
        --      Dollar = { text = "$", prio = 1 },
        --      MatchingPair = { text = "%", prio = 5 },
        --      Zero = { text = "0", prio = 1 },
        --      w = { text = "w", prio = 10 },
        --      b = { text = "b", prio = 9 },
        --      e = { text = "e", prio = 8 },
        --      W = { text = "W", prio = 7 },
        --      B = { text = "B", prio = 6 },
        --      E = { text = "E", prio = 5 },
        -- },
        -- gutterHints = {
        --     -- prio is not currently used for gutter hints
        --     G = { text = "G", prio = 1 },
        --     gg = { text = "gg", prio = 1 },
        --     PrevParagraph = { text = "{", prio = 1 },
        --     NextParagraph = { text = "}", prio = 1 },
        -- },
      })
    end,
  },

  --Dashboard
  {
    "goolord/alpha-nvim",
    config = function()
      require("pluginconfigs.dashboard")
    end
  },

  -- Status Line
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      options = {
        component_separators = '|',
        section_separators = '',
      },

      sections = {
        lualine_b = {
          'branch',
          'diff',
          {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic" }
          }
        },
        lualine_c = { { 'filename', path = 3 } },
      }
    }
  },

  -- Tab Line
  {
    'romgrk/barbar.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
    },
  },

  --------------------------------------
  -- File explorer and Finder --
  --------------------------------------

  -- Nvim Tree
  {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    cmd = "NvimTreeToggle",
    -- event = "CursorHold",
    dependencies = {
      -- Rename packages and imports also when renaming/moving files via nvim-tree.
      -- Currently works only for tsserver (used in Angular development)
      {
        "antosha417/nvim-lsp-file-operations",
        config = function()
          require("lsp-file-operations").setup()
        end,
      },
      -- Rename packages and imports when renaming via nvim-tree for java
      {
        'simaxme/java.nvim',
        ft = "java",
        dependencies = { "mfussenegger/nvim-jdtls" },
        config = function()
          require("simaxme-java").setup()
        end
      }
    },
    config = function()
      require("nvim-tree").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        view = {
          width = 50,
        },
      })
    end,
  },

  --Telescope Fuzzy Finder (files, commands, etc)
  {
    'nvim-telescope/telescope.nvim',
    -- lazy = true,
    -- cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "ahmedkhalf/project.nvim",
        -- event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = function()
          require("project_nvim").setup({
            -- Methods of detecting the root directory. **"lsp"** uses the native neovim
            -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
            -- order matters: if one is not detected, the other is used as fallback. You
            -- can also delete or rearangne the detection methods.
            detection_methods = { "pattern", "lsp" },

            -- All the patterns used to detect root dir, when **"pattern"** is in
            -- detection_methods
            patterns = { ".git" },

          })
          require('telescope').load_extension("projects")
        end
      },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          path_display = { "smart" },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = false
          },
          oldfiles = {
            theme = "dropdown",
            previewer = false
          },
          live_grep = {
            theme = "ivy"
          },
          buffers = {
            theme = "dropdown",
            previewer = false
          }
        },
      })
    end
  },

  {
    "smartpde/telescope-recent-files",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      handlers = {},
    },
    config = function()
      require("telescope").load_extension("recent_files")
    end,
  },

  {
    "debugloop/telescope-undo.nvim",
    dependencies = { -- note how they're inverted to above example
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        undo = {
          -- telescope-undo.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },

  --------------------------------------
  -- LSP & Autocompletion --
  --------------------------------------

  {
    'nvim-java/nvim-java',
    lazy = false,
    dependencies = {
      'nvim-java/lua-async-await',
      'nvim-java/nvim-java-refactor',
      'nvim-java/nvim-java-core',
      'nvim-java/nvim-java-test',
      'nvim-java/nvim-java-dap',
      'MunifTanjim/nui.nvim',
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      {
        'williamboman/mason.nvim',
        opts = {
          registries = {
            'github:nvim-java/mason-registry',
            'github:mason-org/mason-registry',
          },
        },
      }
    },
    config = function()
      require('java').setup({
        root_markers = {
          '.git',
          'mvnw',
          'gradlew',
          'pom.xml',
          'build.gradle',
        },
        jdk = {
          -- Choose whether to install jdk automatically using mason.nvim
          auto_install = false,
        },
      })
    end
  },

  { "williamboman/mason-lspconfig.nvim", lazy = true },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'amarakon/nvim-cmp-buffer-lines',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require "pluginconfigs.cmp"
    end
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
    branch = 'v3.x',
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- disable semanticTokens because they interfere with treesitter
        if client.supports_method "textDocument/semanticTokens" then
          client.server_capabilities.semanticTokensProvider = nil
        end
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({

        -- You can add more ensure installed servers based on the aliases on this list: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
        ensure_installed = { 'jdtls', "tsserver", "lua_ls", "jsonls", "lemminx", "marksman", "emmet_ls", "gradle_ls", "html", "cssls", "bashls", "angularls", 'quick_lint_js' },
        handlers = {

          -- This is custom configuration for jdtls.
          -- Take a look at the config there to adjust it to your preferences
          jdtls = function()
            require('lspconfig').jdtls.setup({
              capabilities = require("pluginconfigs.jdtls").capabilities,
              settings = require("pluginconfigs.jdtls").settings,
            })
          end,

          -- This is the default configuration for all servers except jdtls
          function(server_name)
            require('lspconfig')[server_name].setup({
              defaults = require("pluginconfigs.lsp").defaults(),
              capabilities = require("pluginconfigs.lsp").capabilities,
            })
          end,
        }
      })
    end
  },

  -- Status updates for LSP - Not very useful - probably unnecessary
  -- {
  --   'j-hui/fidget.nvim',
  --   event = "LspAttach",
  --   opts = {
  --     progress = {
  --       poll_rate = 200,             -- How and when to poll for progress messages
  --       suppress_on_insert = true,   -- Suppress new messages while in insert mode
  --       ignore_done_already = true,  -- Ignore new tasks that are already complete
  --       ignore_empty_message = true, -- Ignore new tasks that don't contain a message
  --     }
  --   }
  -- },

  -- Improves LSP UI
  {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    },
    opts = {
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = false,
        folder_level = 6,
      },
      outline = {
        auto_preview = false,
        win_width = 50
      }
    }
  },

  -- Shows signature as you type
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = { hint_enable = false, time_interval = 50 },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },

  {
    "rockerBOO/symbols-outline.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    branch = "main",
    event = "BufEnter",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  --LSP Diagnostics
  {
    "folke/trouble.nvim",
    branch = "dev",
    lazy = true,
    cmd = "Trouble",
    opts = { auto_preview = false } -- automatically preview the location of the diagnostic
  },

  -- This plugin ensures that the necessary dependencies for Dusk.nvim get automatically installed
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = function()
      require('mason-tool-installer').setup {

        ensure_installed = {
          'bash-language-server',
          'google-java-format',
          'stylua',
          'shellcheck',
          'shfmt',
          'java-test',
          'java-debug-adapter',
          'markdown-toc',
          'lombok-nightly',
          'sonarlint-language-server'
        },
        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,
        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 3000, -- 3 second delay
      }
    end

  },

  -- nvim-jdtls enhances the functionality of Java lsp server (jdtls)
  { "mfussenegger/nvim-jdtls",           ft = "java" },

  -- Sonarlint plugin
  {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = { "java", "python", "cpp", "typescript", "typescriptreact", "html" },
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      handlers = {},
    },
    config = function()
      require("sonarlint").setup({
        server = {
          -- root_dir = require('jdtls.setup').find_root({ 'gradlew', '.git', 'pom.xml', 'mvnw' }),
          autostart = true,
          cmd = {
            "sonarlint-language-server",
            -- Ensure that sonarlint-language-server uses stdio channel
            "-stdio",
            "-analyzers",
            -- paths to the analyzers you need, using those for python and java in this example
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
          },
          settings = {
            sonarlint = {
              pathToCompileCommands = vim.fn.getcwd() .. "/compile_commands.json",
            },
          },
        },
        filetypes = {
          -- Tested and working
          "python",
          "cpp",
          -- Requires nvim-jdtls, otherwise an error message will be printed
          "java",
          "typescript",
          "html",
        },
      })
    end,
  },

  -- -- NOTE: if you want additional linters, try this plugin
  -- -- Linters
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = "LspAttach",
  --   config = function()
  --     local lint = require("lint")
  --
  --     lint.linters_by_ft = {
  --       -- javascript = { "eslint_d" },
  --       -- typescript = { "eslint_d" },
  --       -- javascriptreact = { "eslint_d" },
  --       -- typescriptreact = { "eslint_d" },
  --       java = { "checkstyle" },
  --     }
  --     local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  --
  --     vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  --       group = lint_augroup,
  --       callback = function()
  --         lint.try_lint()
  --       end,
  --     })
  --   end
  -- },

  -- DAP (Required to run Java unit tests and Debugging)--
  { "mfussenegger/nvim-dap",           ft = "java" },
  { "rcarriga/nvim-dap-ui",            ft = "java", dependencies = { "nvim-neotest/nvim-nio" }, opts = {} },
  { 'theHamsta/nvim-dap-virtual-text', ft = "java", opts = {} },

  -- Obsolete plugins, might re-use later
  -- { "Pocco81/dap-buddy.nvim",  ft = "java" },

  --------------------------------------
  -- Git --
  --------------------------------------
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = "CursorHold",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 1200, virtual_text_pos = "eol" }
    }
  },

  {
    "akinsho/git-conflict.nvim",
    event = "CursorHold",
    config = function()
      require("git-conflict").setup()
    end,
  },

  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose" },
  },

  { "kdheepak/lazygit.nvim",   lazy = true,   cmd = "LazyGit" },

  --------------------------------------
  -- Tools --
  --------------------------------------

  -- Syntax highliting
  {
    'nvim-treesitter/nvim-treesitter',
    event = "CursorHold",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'andymass/vim-matchup',
    },
    build = ':TSUpdate',
    config = function()
      require("pluginconfigs.treesitter")
    end,
  },

  -- Custom Formatters
  {
    'stevearc/conform.nvim',
    lazy = true,
    event = "LspAttach",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          java = { "google-java-format" },
        },
      })
    end
  },

  -- auto save
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      execution_message = {
        enabled = false,
      },
      debounce_delay = 5000,
    },
  },

  {
    "saccarosium/nvim-whitespaces",
    lazy = false,
    opts = {
      handlers = {},
    },
  },

  {
    "booperlv/nvim-gomove",
    event = "VeryLazy",
    opts = {
      handlers = {},
    },
  },

  -- Docker
  -- LazyDocker app is required https://github.com/mgierada/lazydocker.nvim?tab=readme-ov-file#-installation
  {
    "mgierada/lazydocker.nvim",
    event = "VeryLazy",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
      require("lazydocker").setup({})
    end
  },

  -- Database
  {
    "tpope/vim-dadbod",
    event = "VeryLazy",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("pluginconfigs.dadbod").setup()
    end,
  },

  --Terminal
  { 'akinsho/toggleterm.nvim', version = "*", lazy = true,     cmd = "ToggleTerm", opts = {} },

  --Search & replace string
  { "nvim-pack/nvim-spectre",  lazy = true,   cmd = "Spectre", opts = {} },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  -- gcc to comment
  {
    'numToStr/Comment.nvim',
    event = "CursorHold",
    opts = {},
  },

  -- autoclose (), {} etc
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },

  -- autoclose tags
  {
    'windwp/nvim-ts-autotag',
    event = { "InsertEnter" },
    opts = {}

  },

  --Markdown
  { "dkarter/bullets.vim",           ft = "markdown" }, -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
  { "jghauser/follow-md-links.nvim", ft = "markdown" }, --Follow md links with ENTER
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    -- install without yarn or npm
    build = function() vim.fn["mkdp#util#install"]() end,
  }
}, {})
