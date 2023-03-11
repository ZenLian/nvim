local M = {}

local util = require('util')

local options = {
  provider = {
    -- :h g:python3_host_prog
    python3 = '~/.miniconda3/envs/py3-nvim/bin/python3',
  },
  dirs = {
    config = vim.fn.stdpath('config'),
    -- home = vim.env.HOME
    cache = util.join_path(vim.env.HOME, '.cache', 'nvim'),
    data = util.join_path(vim.fn.stdpath('data'), 'site'),
  },
  format_on_save = true,
  format_priority = { -- default to 0 for not configured servers
    ['null-ls'] = 1,
  },
  animation = false,

  icons = {
    cmp_kinds = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '',
      Field = 'ﰠ',
      Variable = '',
      Class = 'ﴯ',
      Interface = '',
      Module = '',
      Property = 'ﰠ',
      Unit = '',
      -- Unit = "塞",
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = 'פּ',
      Event = '',
      Operator = '',
      TypeParameter = '',
    },
  },
}

M._setup = false

function M.setup(opts)
  M._setup = true
  options = vim.tbl_deep_extend('force', options, opts or {})

  -- pcall(require, 'impatient')

  -- later vim.notify
  require('util').lazy_notify()

  require('config.autocmds').setup()
  require('config.keymaps')
  require('config.options').setup()
end

return setmetatable(M, {
  __index = function(_, key)
    if not M._setup then
      M.setup()
    end
    ---@diagnostic disable-next-line: need-check-nil
    return options[key]
  end,
})
