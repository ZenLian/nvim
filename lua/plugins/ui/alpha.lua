local spec = {
  'goolord/alpha-nvim',
  cond = true,
  event = 'BufWinEnter',
}

local function list_sessions()
  local startify = require('alpha.themes.startify')
  local items_number = 10
  local num = 0
  local sessions = {}
  for _, sfile in ipairs(require('persistence').list()) do
    if vim.fn.filereadable(sfile) ~= 0 then
      num = num + 1
      sessions[num] = sfile
    end
    if num >= items_number then
      break
    end
  end
  table.sort(sessions, function(a, b)
    return vim.loop.fs_stat(a).mtime.sec > vim.loop.fs_stat(b).mtime.sec
  end)

  local items = {}
  for i, sfile in ipairs(sessions) do
    items[i] = startify.button(tostring(i - 1), sfile, '<cmd>silent! source ' .. vim.fn.fnameescape(sfile) .. ' <CR>')
  end
  return {
    type = 'group',
    val = items,
    opts = {},
  }
end

spec.config = function()
  local alpha = require('alpha')
  local startify = require('alpha.themes.startify')

  -- header
  startify.section.header.val = {
    '                                                     ',
    '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
    '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
    '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
    '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
    '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
    '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
    '                                                     ',
  }
  startify.section.header.opts.hl = 'Function'

  startify.section.top_buttons.val = {
    startify.button('e', 'New file', '<cmd>ene <CR>'),
    startify.button('f', 'File picker', '<cmd>Telescope find_files<CR>'),
    startify.button('q', 'Quit', '<cmd>q <CR>'),
  }

  startify.section.mru_cwd.val = {
    { type = 'padding', val = 1 },
    { type = 'text', val = 'Sessions', opts = { hl = 'SpecialComment' } },
    { type = 'padding', val = 1 },
    {
      type = 'group',
      val = function()
        return { list_sessions() }
      end,
      opts = { shrink_margin = false },
    },
  }

  startify.section.bottom_buttons.val = {}

  local fortune = require('alpha.fortune')
  startify.section.footer.type = 'text'
  startify.section.footer.val = fortune(120)
  startify.section.footer.opts = {
    -- position = 'center',
    hl = 'Number',
  }
  -- startify.section.footer.opts.hl = 'String'

  -- local dashboard = require('alpha.themes.dashboard')
  -- dashboard.section.footer.val = fortune(120)

  alpha.setup(startify.config)

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
