vim.pack.add({
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.extra'
})

require('mini.extra').setup()

local ai = require('mini.ai')
require('mini.ai').setup({
  n_lines = 500,
  custom_textobjects = {
    o = ai.gen_spec.treesitter { -- code block
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    },
    f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
    c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
    d = { '%f[%d]%d+' }, -- digits
    g = MiniExtra.gen_ai_spec.buffer(), -- whole buffer
    i = MiniExtra.gen_ai_spec.indent(),
  },
})
