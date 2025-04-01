
local function bootstrap()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.uv.fs_stat(lazypath) then
    local result = vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      'https://github.com/folke/lazy.nvim.git',
      lazypath
    }
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
        { result, 'WarningMsg' },
        { '\nPress any key to exit...' },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

local function setup()
  require('lazy').setup {
    spec = {
      { import = 'zenlian/plugins' },
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
          -- 'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
    -- Enable luarocks if installed.
    rocks = { enabled = vim.fn.executable('luarocks') == 1},
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
end

bootstrap()
setup()