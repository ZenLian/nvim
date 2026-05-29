vim.pack.add({'https://github.com/ibhagwan/fzf-lua'})

local opts = {
  nbsp = '\xc2\xa0',
  files = {
    cmd = [[fd --color=never --hidden --type f --type l --exclude .git --exclude .cache --exclude .svn]],
  },
  keymap = {
    builtin = {
      true,
      ['<c-f>'] = 'preview-page-down',
      ['<c-b>'] = 'preview-page-up',
    },
    fzf = {
      true,
      ['ctrl-u'] = 'half-page-down',
      ['ctrl-d'] = 'half-page-up',
      ['ctrl-f'] = 'preview-page-down',
      ['ctrl-b'] = 'preview-page-up',
    },
  },
  actions = {
    files = {
      true, -- uncomment to inherit all the below in your custom config
      -- ['ctrl-x'] = Util.lazy.has('trouble.nvim') and require('trouble.sources.fzf').actions.open or nil,
    },
  },
}
require('fzf-lua').setup(opts)
require('fzf-lua').register_ui_select {
  winopts = {
    width = 0.60,
  },
}

-- resume
vim.keymap.set(
  'n',
  '<leader><space>',
  '<cmd>FzfLua resume<cr>',
  { desc = 'Resume picker' }
)
-- find files
vim.keymap.set(
  'n',
  '<leader>ff',
  function()
    require('fzf-lua').files()
  end,
  { desc = 'Find Files (Root Dir)' }
)
vim.keymap.set(
  'n',
  '<C-p>',
  function()
    require('fzf-lua').files { previewer = false, winopts = { width = 0.60 } }
  end,
  {desc = 'Find Files (Root Dir)'}
)
vim.keymap.set('n', '<leader>fr', '<cmd>FzfLua oldfiles<cr>', { desc = 'Recent Files' })
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua git_files<cr>', { desc = 'Git Files' })
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', { desc = 'Buffers' })
-- Search/Greps
vim.keymap.set('n', '<leader>sg', '<cmd>FzfLua live_grep<cr>',{ desc = 'Grep (CWD)' })
vim.keymap.set('n', '<leader>sw', '<cmd>FzfLua grep_cword<cr>',{ desc = 'Current Word (CWD)' })
vim.keymap.set('v', '<leader>sw', '<cmd>FzfLua grep_visual<cr>',{ desc = 'Selection (CWD)' })
vim.keymap.set('n', '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>', { desc = 'Grep (Buffer)' })

-- misc
vim.keymap.set('n', '<leader>f"', '<cmd>FzfLua registers<cr>',{desc = 'Registers' })
vim.keymap.set('n', '<leader>fH', '<cmd>FzfLua highlights<cr>',{desc = 'Highlights' })
vim.keymap.set('n', '<leader>fK', '<cmd>FzfLua keymaps<cr>',{desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fM', '<cmd>FzfLua manpages<cr>',{desc = 'Manpages' })
vim.keymap.set('n', '<leader>fC', '<cmd>FzfLua colorschemes<cr>',{desc = 'Colorschemes' })
