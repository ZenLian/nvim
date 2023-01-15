local leap = {
  'ggandor/leap.nvim',
  event = { 'BufRead', 'BufNewFile' },
  dependencies = {
    'tpope/vim-repeat',
    'flit.nvim',
  },
  opts = {
    highlight_unlabeled_phase_one_targets = false,
    case_sensitive = false,
    equivalence_classes = {
      ' \t\r\n',
      '"\'`',
      ',([{<',
      '.>}])',
    },
    special_keys = {
      repeat_search = '<enter>',
      next_phase_one_target = '<enter>',
      next_target = { '<enter>', ';' },
      prev_target = { '<space>', ',' },
      next_group = '<tab>',
      prev_group = '<space>',
      multi_accept = '<enter>',
      multi_revert = '<backspace>',
    },
  },
  config = function(_, opts)
    local leap = require('leap')
    leap.setup(opts)
    -- require('leap').add_default_mappings(true)
    local util = require('util')
    util.keymaps {
      ['s'] = { '<Plug>(leap-forward-to)' },
      ['S'] = { '<Plug>(leap-backward-to)' },
      ['x'] = { '<Plug>(leap-forward-to)', mode = { 'x', 'o' } },
      ['X'] = { '<Plug>(leap-backward-to)', mode = { 'x', 'o' } },
      ['gs'] = { '<Plug>(leap-cross-window)', mode = { 'n', 'x', 'o' } },
    }
  end,
}

local flit = {
  'ggandor/flit.nvim',
  opts = {
    keys = { f = 'f', F = 'F', t = 't', T = 'T' },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = 'nvo',
    multiline = true,
    -- Like `leap`s similar argument (call-specific overrides).
    -- E.g.: opts = { equivalence_classes = {} }
    opts = {},
  },
}

local M = {}

return setmetatable({ leap, flit }, { __index = M })
