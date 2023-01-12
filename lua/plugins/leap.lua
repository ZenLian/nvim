local leap = {
  'ggandor/leap.nvim',
  event = 'VeryLazy',
  dependencies = { 'flit.nvim' },
  config = function()
    require('leap').setup {
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
    }
    require('leap').add_default_mappings()
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

return { leap, flit }
