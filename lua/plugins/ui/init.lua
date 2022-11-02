local ui = {}
local util = require('core.util')

--#region colorschemes
-- ui['zenlian/edgeme'] = {
-- ui['tjdevries/colorbuddy.nvim'] = {
-- ui['Mofiqul/vscode.nvim'] = {
-- ui['ThemerCorp/themer.lua'] = {
-- ui['~/source/edgeme'] = {}
ui['catppuccin/nvim'] = {
  as = 'catppuccin',
  -- run = ':CatppuccinCompile',
  -- ui[util.source_dir('nvdark.nvim')] = {
  config = function()
    require('plugins.ui.theme')
  end,
}
--#endregion colorschemes

ui['windwp/windline.nvim'] = {
  event = 'VimEnter',
  config = function()
    require('plugins.ui.windline')
  end,
}

ui['akinsho/bufferline.nvim'] = {
  tag = 'v2.*',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('plugins.ui.bufferline')
  end,
}

ui['goolord/alpha-nvim'] = {
  event = 'BufWinEnter',
  config = function()
    require('plugins.ui.alpha')
  end,
}

ui['lukas-reineke/indent-blankline.nvim'] = {
  opt = true,
  event = 'BufRead',
  config = function()
    require('plugins.ui.indent_blankline')
  end,
}

ui['NvChad/nvim-colorizer.lua'] = {
  config = function()
    require('plugins.ui.colorizer')
  end,
}

-- TODO: looking for neovim only replacement
ui['RRethy/vim-illuminate'] = {
  config = function()
    require('plugins.ui.illumimate')
  end,
}

ui['folke/zen-mode.nvim'] = {
  opt = true,
  cmd = { 'ZenMode' },
  config = function()
    require('plugins.ui.zen_mode')
  end,
}

ui['folke/twilight.nvim'] = {
  opt = true,
  cmd = { 'Twilight' },
  config = function()
    require('twilight').setup {}
  end,
}

ui['rcarriga/nvim-notify'] = {
  event = 'VimEnter',
  config = function()
    require('plugins.ui.notify')
  end,
}

-- provide prettier ui hook for vim.ui.input and vim.ui.select
ui['stevearc/dressing.nvim'] = {
  config = function()
    require('plugins.ui.dressing')
  end,
}

ui['anuvyklack/pretty-fold.nvim'] = {
  config = function()
    require('pretty-fold').setup {}
  end,
  event = 'BufRead',
}

return ui
