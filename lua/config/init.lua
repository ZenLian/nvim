local M = {}

local util = require('util')

M.config = {
  provider = {
    -- :h g:python3_host_prog
    python3 = '~/.miniconda3/envs/py3-nvim/bin/python3',
  },
  -- packer
  packer = {
    local_dir = '~/projects',
    git_src = 'default', -- one of 'default'/'ssh'/'gitclone'/'kgithub'
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
}

function M.setup()
  -- speedup
  -- require('impatient').enable_profile()
  pcall(require, 'impatient')

  require('config.options').setup()
  require('config.keymaps').setup()
  require('config.autocmds')
  require('config.plugins')
end

return M
