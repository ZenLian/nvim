local spec = {
  'andymass/vim-matchup',
  event = { 'BufReadPost', 'BufNewFile' },
  init = function()
    local util = require('util')
    util.keymaps {
      -- ['%'] = { '<plug>(matchup-%)', mode = { 'n', 'x' } },
      ['gm'] = { '<plug>(matchup-g%)', mode = { 'n', 'x' } },
      ['[m'] = { '<plug>(matchup-[%)', mode = { 'n', 'x' } },
      [']m'] = { '<plug>(matchup-]%)', mode = { 'n', 'x' } },
      -- ['z%'] = { '<plug>(matchup-z%)', mode = { 'n', 'x' } },
      ['am'] = { '<plug>(matchup-a%)', mode = { 'x' } },
      ['im'] = { '<plug>(matchup-i%)', mode = { 'x' } },
      ['dsm'] = { '<plug>(matchup-ds%)' },
      ['csm'] = { '<plug>(matchup-cs%)' },
      -- [''] = { '<plug>(matchup-hi-surround)' },
    }
  end,
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
  end,
}

return { spec }
