return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'lua_ls' },
      servers = {
        lua_ls = {
          -- custom keymaps
          keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = 'Replace',
              },
              doc = {
                privateName = { '^_' },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
            },
          },
        },
      },
    },
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'stylua',
      },
    },
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'lazy.nvim', words = { 'LazyVim' } },
        { path = 'mini.ai', words = { 'MiniExtra' } },
      },
    },
  },
}
