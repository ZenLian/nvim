local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- require('lazy.view.config').keys.details = '<Tab>'
require('lazy').setup {
  spec = {
    { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    { import = 'lazyvim.plugins.extras.coding.yanky' },
    { import = 'lazyvim.plugins.extras.editor.aerial' },
    -- { import = 'lazyvim.plugins.extras.editor.navic' },
    { import = 'lazyvim.plugins.extras.formatting.prettier' },
    { import = 'lazyvim.plugins.extras.lang.clangd' },
    -- custom
    { import = 'plugins' },
    { import = 'plugins.extras' },
    { import = 'plugins.lang' },
  },
  defaults = {
    lazy = true, -- every plugin is lazy-loaded by default
    version = false, -- always use the latest git commit
    -- version = '*', -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { 'catppuccin', 'habamax' } },
  -- automatically check for plugin updates
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = { enabled = true, notify = false },
  dev = {
    -- directory where you store your local plugin projects
    path = '~/projects',
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = { 'ZenLian' },
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  ui = {
    border = 'rounded',
  },
  custom_keys = {
    -- open a terminal for the plugin dir
    ['<leader>t'] = function(plugin)
      require('lazy.util').float_term(nil, {
        cwd = plugin.dir,
      })
    end,
    -- open lazygit log
    ['<leader>l'] = function(plugin)
      require('lazy.util').float_term({ 'gitui' }, {
        cwd = plugin.dir,
      })
    end,
  },
}
