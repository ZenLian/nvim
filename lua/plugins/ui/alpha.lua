local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')
local WIDTH = 30

-- header
-- dashboard.section.header.val = {
--   '                                                     ',
--   '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
--   '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
--   '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
--   '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
--   '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
--   '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
--   '                                                     ',
-- }
dashboard.section.header.val = {
  '                                    ',
  '  ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ',
  '  ████╗  ██║██║   ██║██║████╗ ████║ ',
  '  ██╔██╗ ██║██║   ██║██║██╔████╔██║ ',
  '  ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  '  ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  '  ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
  '                                    ',
}
-- dashboard.section.header.opts.hl = "Function"

-- buttons
local function button(...)
  local btn = dashboard.button(...)
  -- btn.opts.hl = "Type"
  -- btn.opts.hl_shortcut = "Function"
  -- btn.opts.cursor = 0
  btn.opts.width = WIDTH
  return btn
end

dashboard.section.buttons.val = {
  button('e', '   New', ':ene<CR>'),
  button('f', '   Files', ':Telescope find_files<CR>'),
  button('r', '   Recent', ':Telescope oldfiles<CR>'),
  button('s', '   Sessions', '<cmd>SessionManager load_session<CR>'),
  button('c', '   Configs', ':e $MYVIMRC | :cd %:p:h<CR>'),
  button('q', '   Quit', ':qa<CR>'),
}

local fortune = require('alpha.fortune')
dashboard.section.footer.val = fortune(50)
dashboard.section.footer.opts.hl = 'String'

alpha.setup(dashboard.config)
