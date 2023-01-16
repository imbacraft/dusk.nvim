local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Performance
pcall(require, "impatient") -- Call impatient plugin before all others to improve performance. Keep this line here.

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  ---------------------
  -- Package Manager --
  ---------------------
  use("wbthomason/packer.nvim") -- Packer manage itself

  ----------------------
  -- Required plugins --
  ----------------------
  -- Improve startup time (source: https://alpha2phi.medium.com/neovim-for-beginners-performance-95687714c236)
  use("lewis6991/impatient.nvim")
  use("nvim-lua/plenary.nvim")
  use({
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup()
    end,
  })

  ----------------------
  -- General --
  ----------------------

  -- Measure nvim startup time
  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  --Smooth scrolling
  use({
    "karb94/neoscroll.nvim",
    event = 'WinScrolled',
    config = function()
      require("neoscroll").setup()
    end,
  })

  --Automatically create any non-existent directories before writing the buffer.
  use({ "jghauser/mkdir.nvim", event = "CursorHold" })

  -- Colorschemes
  use("B4mbus/oxocarbon-lua.nvim")
  use({ "EdenEast/nightfox.nvim" })

  -- Buffer (Tab) line
  -- use("akinsho/bufferline.nvim")

  --Dashboard
  use("goolord/alpha-nvim")

  -- Key Navigator
  use("folke/which-key.nvim")

  -- Electric indentation
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  --------------------------------------
  -- File Navigation and Fuzzy Search --
  --------------------------------------

  -- Nvim Tree
  use({
    "nvim-tree/nvim-tree.lua",
    tag = "nightly", -- optional, updated every week. (see issue #1193)
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
      })
    end,
  })

  use({
    {
      'nvim-telescope/telescope.nvim',
      cmd = 'Telescope',
      config = function()
        require("telescope").setup({
          path_display = { "smart" },
        })
      end,
    },
    {
      "ahmedkhalf/project.nvim",
      after = 'telescope.nvim',
      config = function()
        require("project_nvim").setup()
        require('telescope').load_extension("projects")
      end,
    },
  })

  --------------------------------------
  -- Autocompletion --
  --------------------------------------

  use({
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      config = function()
        require('plugins.cmp')
      end,
      requires = {
        {
          'L3MON4D3/LuaSnip',
          requires = {
            {
              'rafamadriz/friendly-snippets',
            },
          },
        },
      },
    },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
  })


  --------------------------------------
  -- LSP --
  --------------------------------------
  -- LSP
  use({
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.lsp')
    end,
    requires = {
      {
        -- WARN: Unfortunately we won't be able to lazy load this
        'hrsh7th/cmp-nvim-lsp',
      },
    },
  })

  use({ "williamboman/mason.nvim" }) -- New LSP Installer
  use({ "williamboman/mason-lspconfig.nvim" }) -- New LSP server Installer


  -- Java LSP
  use({ "mfussenegger/nvim-jdtls", ft = "java" })

  -- DAP (Required to run Java unit tests)--
  use({ "mfussenegger/nvim-dap", ft = "java" })
  use({ "Pocco81/DAPInstall.nvim", ft = "java" })

  -- Code Runner
  use({ "is0n/jaq-nvim", event = "CursorHold",
    config = function()
      require("plugins.jaq")
    end })

  --  Formatters
  use { 'mhartington/formatter.nvim',
    event = "CursorHold",
    config = function()
      require("plugins.formatter")
    end
  }

  --LSP diagnostics
  use({
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  })

  --------------------------------------
  -- Features --
  --------------------------------------

  --Terminal
  use({ "kassio/neoterm", cmd = "T" }) --Send shell commands to new buffer-terminal.

  --Testing
  use({ "vim-test/vim-test", cmd = { "TestFile", "TestNearest", "TestSuite", "TestVisit" } })

  --REST API requests
  use({
    "NTBBloodbath/rest.nvim",
    ft = "http",
    config = function()
      require("plugins.restnvim")
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  --------------------------------------
  -- Editing Enhancements --
  --------------------------------------

  --Show colors
  use({ "norcalli/nvim-colorizer.lua", event = "CursorHold",
    config = function()
      require 'colorizer'.setup()
    end })

  --Replace with sed cmd
  use({
    "windwp/nvim-spectre",
    event = "CursorHold",
    config = function()
      require("spectre").setup()
    end,
  })

  --Handy package with many lightweight editing tools. Choose those that fit you.
  -- Check documentation at https://github.com/echasnovski/mini.nvim
  use({
    "echasnovski/mini.nvim",
    event = "CursorHold",
    config = function()
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.pairs").setup()
      require("mini.comment").setup()
      require("mini.jump").setup()
      require("mini.jump2d").setup()
      require("mini.surround").setup()
      require("mini.fuzzy").setup()
    end,
  })

  --------------------------------------
  -- File type specific --
  --------------------------------------

  --Markdown
  use({ "dkarter/bullets.vim", ft = "markdown" }) -- Automatic ordered lists. For reordering messed list, use :RenumberSelection cmd
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  }) --Markdown preview
  use({ "jghauser/follow-md-links.nvim", ft = "markdown" }) --Follow md links with ENTER

  --Csv
  use({ "mechatroner/rainbow_csv", ft = "csv" })

  --------------------------------------
  -- Git --
  --------------------------------------
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("gitsigns").setup()
    end,
  })

  use({ "f-person/git-blame.nvim", event = "CursorHold" })

  use({
    "akinsho/git-conflict.nvim", event = "CursorHold",
    tag = "*",
    config = function()
      require("git-conflict").setup()
    end,
  })

  use({ "kdheepak/lazygit.nvim", cmd = "LazyGit" })


  -----------------------------------
  -- Treesitter --
  -----------------------------------

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- Syntax highlighting
  -- use("nvim-treesitter/nvim-treesitter-textobjects") -- Extra text objects for better selecting
  -- use({ "windwp/nvim-ts-autotag" }) -- Auto close tags
  -- use({ "windwp/nvim-autopairs" }) -- Autoclose quotes, parentheses etc.

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
