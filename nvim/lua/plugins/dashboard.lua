local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"


dashboard.section.header.val = {

" ",
" ",
" ",
" ",
" ",
" ",                                                     

                                                  
" _____                 _     ",
"(____ \\               | |    ",
" _   \\ \\  _   _   ___ | |  _ ",
"| |   | || | | | /___)| | / )",
"| |__/ / | |_| ||___ || |< ( ",
"|_____/   \\____|(___/ |_| \\_)",
                             
"",
"         N E O V I M"
                                      
                                                                                                                                                           
                                                                                                             
}



dashboard.section.buttons.val = {
  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files hidden=true no_ignore=true <CR>"),
  dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
