local config = {
  provider = {
    -- :h g:python3_host_prog
    python3 = '~/.miniconda3/envs/py3-nvim/bin/python3',
  },
  format_on_save = true,
  format_priority = { -- default to 0 for not configured servers
    ['null-ls'] = 1,
  },
}

return config
