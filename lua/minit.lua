-- used for minimum vimrc debug

local config = function()
  local notify = require('notify')

  notify.setup {
    --stages = 'slide',
    timeout = 1000,
  }

  vim.notify = notify
  -- LSP
  -- https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes#lsp-messages
  local severity = {
    'error',
    'warn',
    'info',
    'info', -- map both hint and info to info?
  }
  vim.lsp.handlers['window/showMessage'] =
    function(_, method, params, _) vim.notify(method.message, severity[params.type]) end
end

local function setup_packer()
  local fn = vim.fn
  local packer_dir = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

  local packer_bootstrap = nil
  if fn.empty(fn.glob(packer_dir)) > 0 then
    packer_bootstrap =
      fn.system { 'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir }
  end

  vim.cmd([[packadd packer.nvim]])
  local packer = require('packer')
  packer.startup {
    function(use)
      use { 'wbthomason/packer.nvim', opt = true }
      use {
        'rcarriga/nvim-notify',
        event = 'VimEnter',
        config = config,
      }
    end,
    config = {
      display = {
        open_fn = function() return require('packer.util').float { border = 'single' } end,
      },
    },
  }

  if packer_bootstrap then packer.sync() end
end

setup_packer()

vim.o.termguicolors = true
vim.keymap.set('n', '<C-p>', function() vim.notify('this is an info', vim.log.levels.INFO, { title = 'minimal' }) end)
