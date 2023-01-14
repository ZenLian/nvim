local spec = {
  'goolord/alpha-nvim',
  event = 'BufWinEnter',
}

spec.config = function()
  local alpha = require('alpha')
  local dashboard = require('alpha.themes.dashboard')
  local util = require('util')
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
  dashboard.section.header.opts.hl = 'Function'

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
    button('f', '   Files', '<cmd>lua require("plugins.telescope").project_files()<CR>'),
    button('r', '   Recent', ':Telescope oldfiles<CR>'),
    button('p', '   Projects', '<cmd>Telescope projects<CR>'),
    button('c', '   Configs', ':e $MYVIMRC | :cd %:p:h<CR>'),
    button('q', '   Quit', ':qa<CR>'),
  }

  local fortune = require('alpha.fortune')
  dashboard.section.footer.val = fortune(50)
  dashboard.section.footer.opts.hl = 'String'

  alpha.setup(dashboard.config)

  local group = vim.api.nvim_create_augroup('plugins.alpha', { clear = true })
  vim.api.nvim_create_autocmd('User', {
    group = group,
    pattern = 'AlphaReady',
    callback = function()
      vim.o.showtabline = 0
      vim.wo.cursorline = true
      vim.api.nvim_create_autocmd('BufUnload', {
        group = group,
        buffer = 0,
        callback = function()
          vim.o.showtabline = 2
        end,
      })
      -- keys to disable
      local keys = { 'v', 'V', '<C-v>', 'd', 'D', 'i', 'I', 'C' }
      vim.tbl_map(function(key)
        vim.keymap.set('n', key, '', { buffer = true })
      end, keys)
    end,
  })
  -- vim.cmd([[autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2]])
end

return { spec }
