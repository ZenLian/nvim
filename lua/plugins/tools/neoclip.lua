require('neoclip').setup({
  enable_persistent_history = true,
  db_path = vim.fn.stdpath('data') .. '/databases/neoclip.sqlite3',
  keys = {
    telescope = {
      i = {
        select = '<cr>',
        paste = '<c-p>',
        paste_behind = '<c-l>',
        custom = {},
      },
      n = {
        select = '<cr>',
        paste = 'p',
        paste_behind = 'P',
        custom = {},
      },
    },
  },
})
