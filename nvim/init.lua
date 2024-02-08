-- Set <space> as the leader key
-- See `:help mapleader`
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

  {
    'folke/which-key.nvim',
    lazy = false,
    config = function()
      require("pluginconfigs.whichkey")
    end
  },

  { 'kyazdani42/nvim-web-devicons', lazy = true },

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
    "EdenEast/nightfox.nvim",
    lazy = true,
    event = "CursorHold"

  },

  {
    'nmac427/guess-indent.nvim',
    lazy=true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {}
  },

  { 'ojroques/nvim-bufdel',         event = "CursorHold", opts = {} },

  --Dashboard
  {
    "goolord/alpha-nvim",
    config = function()
      require("pluginconfigs.dashboard")
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    opts = {
      options = {
        -- icons_enabled = false,
        -- theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },

      sections = {
        lualine_b = { 'branch', 'diff', {
          "diagnostics",
          sources = { "nvim_workspace_diagnostic" }
        },
        }
      },
    }
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
    lazy = true,
    cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        "ahmedkhalf/project.nvim",
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = function()
          require("project_nvim").setup()
          require('telescope').load_extension("projects")
        end
      },
    },
  },



  --------------------------------------
  -- LSP & Autocompletion --
  --------------------------------------

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = "CursorHold",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  -- Useful status updates for LSP
  { 'j-hui/fidget.nvim',       event = "LspAttach", opts = {} },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'jdtls', "tsserver" },
        handlers = {
          lsp_zero.default_setup,
          jdtls = lsp_zero.noop, -- This means don't setup jdtls with default setup, because there is special config for it.
        }
      })
    end
  },

  {
    'nvimdev/lspsaga.nvim',
    event = "LspAttach",
    opts = {
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        folder_level = 6,
      }
    }
  },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },

  --LSP Diagnostics
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = "TroubleToggle",
    opts = {auto_preview = false } -- automatically preview the location of the diagnostic
  },

  -- This plugin ensures that the necessary tools get automatically installed
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
          'java-debug-adapter'
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

  -- Java LSP
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- DAP (Required to run Java unit tests and Debugging)--
  { "mfussenegger/nvim-dap",   ft = "java" },
  { "rcarriga/nvim-dap-ui",    ft = "java",         opts = {} },
  { "Pocco81/dap-buddy.nvim",  ft = "java" },

  --------------------------------------
  -- Git --
  --------------------------------------
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = "CursorHold",
    opts = {}
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
    },
    build = ':TSUpdate',
    config = function()
      require("pluginconfigs.treesitter")
    end,
  },

  --Terminal
  { 'akinsho/toggleterm.nvim', version = "*", lazy = true,    cmd = "ToggleTerm", opts = {} },

  -- Code Runner
  {
    "is0n/jaq-nvim",
    lazy = true,
    cmd = "Jaq",
    config = function()
      require("pluginconfigs.jaq")
    end,
  },

  --Search & replace string
  { "nvim-pack/nvim-spectre",        lazy = true,    cmd = "Spectre", opts = {} },

  --Handy package with many lightweight editing tools. Choose those that fit you.
  -- Check documentation at https://github.com/echasnovski/mini.nvim
  {
    "echasnovski/mini.nvim",
    event = "CursorHold",
    config = function()
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
    end,
  },

  --Markdown
  { "dkarter/bullets.vim",           ft = "markdown" }, -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
  { "jghauser/follow-md-links.nvim", ft = "markdown" }, --Follow md links with ENTER

}, {})

--Load the rest of the plugin configurations that need to be loaded at the end
require "pluginconfigs.jdtls"
require "pluginconfigs.cmp"
