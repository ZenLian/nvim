-- used for minimum vimrc debug

local illuminate_config = function()
  require('illuminate').configure {
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
      -- 'treesitter',
      'lsp',
      'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
      'dirvish',
      'fugitive',
      'checkhealth',
      'packer',
      'NvimTree',
      'TelescopePrompt',
      'DressingInput',
      'alpha',
      'aerial',
      'NeogitStatus',
      'NeogitPopup',
    },
    -- modes_denylist = { 'v', 'V' },
    -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
    modes_allowlist = { 'n' },
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
  }
end

local treesitter_config = function()
  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'lua',
      'markdown',
    },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end

local function lsp_config()
  require('lspconfig').sumneko_lua.setup {
    attach = function()
      require('illuminate').attach()
    end,
  }
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
        'RRethy/vim-illuminate',
        config = illuminate_config,
      }
      use {
        'nvim-treesitter/nvim-treesitter',
        config = treesitter_config,
      }
      use {
        'neovim/nvim-lspconfig',
        config = lsp_config,
      }
    end,
    config = {
      display = {
        open_fn = function()
          return require('packer.util').float { border = 'single' }
        end,
      },
    },
  }

  if packer_bootstrap then
    packer.sync()
  end
end

vim.o.termguicolors = true
setup_packer()
