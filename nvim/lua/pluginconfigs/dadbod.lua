local M = {}

local function db_completion()
  require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } }
end

function M.setup()
  vim.g.db_ui_save_location = vim.fn.stdpath "config" .. require("plenary.path").path.sep .. "db_ui"
  -- Your DBUI configuration
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_show_database_icon = 1
  vim.g.db_ui_force_echo_notifications = 1
  vim.g.db_ui_win_position = "right"
  vim.g.db_ui_winwidth = 40

  vim.g.db_ui_table_helpers = {
    mysql = {
      Count = "select count(1) from {optional_schema}{table}",
      Explain = "EXPLAIN {last_query}",
    },
    sqlite = {
      Describe = "PRAGMA table_info({table})",
    },
  }

  vim.g.db_ui_icons = {
    expanded = {
      db = "▾ ",
      buffers = "▾ ",
      saved_queries = "▾ ",
      schemas = "▾ ",
      schema = "▾ פּ",
      tables = "▾ 藺",
      table = "▾ ",
    },
    collapsed = {
      db = "▸ ",
      buffers = "▸ ",
      saved_queries = "▸ ",
      schemas = "▸ ",
      schema = "▸ פּ",
      tables = "▸ 藺",
      table = "▸ ",
    },
    saved_query = "",
    new_query = "璘",
    tables = "離",
    buffers = "﬘",
    add_connection = "",
    connection_ok = "✓",
    connection_error = "✕",
  }

  -- vim.g.dbs = {
  --   { name = "dev", url = "postgres://usr_coas_dev:#k{c!%AV?53aQG?[@localhost:5432/cmpc-pulp-cl-backend-ms-coas" },
  -- }

  local function urlencode(str)
    local function tohex(char)
      return string.format("%%%02X", string.byte(char))
    end
    return string.gsub(str, "[^a-zA-Z0-9_]", tohex)
  end

  vim.g.dbs = {
    {
      name = "dev-coas",
      url = "postgres://usr_coas_dev:"
        .. urlencode("#k{c!%AV?53aQG?[")
        .. "@localhost:5432/cmpc-pulp-cl-backend-ms-coas",
    },
    {
      name = "dev-auth",
      url = "postgres://usr_auth_z_dev:"
        .. urlencode(">_eH!44{BaiST7Lh")
        .. "@localhost:5432/cmpc-pulp-cl-backend-ms-auth-z",
    },
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
    },
    command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "sql",
      "mysql",
      "plsql",
    },
    callback = function()
      vim.schedule(db_completion)
    end,
  })
end

return M
