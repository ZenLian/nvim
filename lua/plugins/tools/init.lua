local tools = {}

-- utilities required by others
tools['nvim-lua/plenary.nvim'] = { opt = true, module = 'plenary' }
tools['tami5/sqlite.lua'] = { opt = true, module = 'sqlite' }

--#region Telescope

tools['nvim-telescope/telescope.nvim'] = {
  opt = true,
  cmd = 'Telescope',
  module = 'telescope',
  requires = { { 'nvim-lua/plenary.nvim' } },
  config = function()
    require('plugins.tools.telescope')
  end,
}

tools['nvim-telescope/telescope-fzf-native.nvim'] = {
  run = 'make',
  after = 'telescope.nvim',
  config = function()
    require('telescope').load_extension('fzf')
  end,
}

tools['nvim-telescope/telescope-frecency.nvim'] = {
  opt = true,
  after = 'telescope.nvim',
  requires = { { 'tami5/sqlite.lua' } },
  config = function()
    require('telescope').load_extension('frecency')
  end,
}

tools['nvim-telescope/telescope-smart-history.nvim'] = {
  opt = true,
  after = 'telescope.nvim',
  requires = { { 'tami5/sqlite.lua' } },
  config = function()
    require('telescope').load_extension('smart_history')
  end,
}

tools['nvim-telescope/telescope-symbols.nvim'] = {
  after = 'telescope.nvim',
}

tools['nvim-telescope/telescope-file-browser.nvim'] = {
  after = 'telescope.nvim',
  config = function()
    require('telescope').load_extension('file_browser')
  end,
}

tools['AckslD/nvim-neoclip.lua'] = {
  requires = {
    { 'tami5/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('plugins.tools.neoclip')
  end,
}

--#endregion Telescope

tools['Shatur/neovim-session-manager'] = {
  config = function()
    require('plugins.tools.session_manager')
  end,
}

tools['kyazdani42/nvim-tree.lua'] = {
  opt = true,
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFindFile', 'NvimTreeRefresh', 'NvimTreeFocus' },
  config = function()
    require('plugins.tools.nvim_tree')
  end,
}

tools['sindrets/diffview.nvim'] = {
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  module = 'diffview',
  config = function()
    require('diffview').setup()
  end,
}

tools['jiaoshijie/undotree'] = {
  cmd = 'UndotreeToggle',
}

tools['akinsho/toggleterm.nvim'] = {
  opt = true,
  module = 'toggleterm',
  cmd = 'ToggleTerm',
  keys = { [[<C-\>]] },
  config = function()
    require('plugins.tools.toggleterm')
  end,
}

tools['folke/todo-comments.nvim'] = {
  opt = true,
  event = { 'BufWinEnter' },
  config = function()
    require('plugins.tools.todo-comments')
  end,
}

tools['TimUntersberger/neogit'] = {
  cmd = 'Neogit',
  config = function()
    require('plugins.tools.neogit')
  end,
}

tools['folke/which-key.nvim'] = {
  config = function()
    require('plugins.tools.whichkey')
  end,
}

tools['dstein64/vim-startuptime'] = {
  opt = true,
  cmd = 'StartupTime',
}

tools['lewis6991/impatient.nvim'] = {
  opt = false,
}

return tools
