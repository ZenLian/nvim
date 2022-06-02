local fn = vim.fn
local config = require('config')

local packer_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local packer_bootstrap
if fn.empty(fn.glob(packer_dir)) > 0 then
  local prefix = 'https://github.com/'
  if config.packer.use_ssh then
    prefix = 'git@github.com:'
  end
  packer_bootstrap = fn.system { 'git', 'clone', '--depth=1', prefix .. 'wbthomason/packer.nvim', packer_dir }
end

-- load packer
local packer = require('packer')

local packer_config = {
  display = {
    open_fn = function()
      return require('packer.util').float {
        border = 'none',
      }
    end,
  },
}

if config.packer.use_ssh then
  packer_config.git = {
    default_url_format = 'git@github.com:%s',
  }
end

packer.startup {
  function(use)
    use { 'wbthomason/packer.nvim' }
    local repos = require('plugins')
    for _, repo in ipairs(repos) do
      use(repo)
    end
    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = packer_config,
}
