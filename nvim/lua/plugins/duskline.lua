-- This is a function to get the branch name
local function branch_name()
  local branch = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
  if branch then
    local name = branch:read("*l")
    branch:close()
    if name then
      return name
    else
      return ""
    end
  end
end

--This autocommand is necessary to keep branch name updated
vim.api.nvim_create_autocmd({"FileType"}, {
  callback = function()
    vim.b.branch_name = branch_name()
  end
})

function _G.status_line()
  return " "
    .. " "
    .. branch_name()
    .. "%="
    .. "%t"
    .. " "
    .. "%h"
    .. "%m"
    .. "%="
    .. "%{&filetype}"
    .. "  "
end

vim.opt.statusline = "%{%v:lua.status_line()%}"

-- Colors of the statusline
vim.cmd("highlight statusline ctermfg=NONE ctermbg=NONE guifg=#33B1FF guibg=NONE")
-- guifg=#525252
