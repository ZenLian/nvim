local PREFIX = ...

local spec = {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    { 'folke/neodev.nvim', config = true },
    {
      'williamboman/mason.nvim',
      opts = {
        github = {
          -- download_url_template = 'https://kgithub.com/%s/releases/download/%s/%s',
        },
        ui = {
          border = 'single',
        },
      },
    },
    'williamboman/mason-lspconfig.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
    {
      'b0o/SchemaStore.nvim',
      dev = true,
    },
    'cmp-nvim-lsp',
  },
  keys = {
    { '<Leader>;l', '<cmd>LspInfo<CR>', desc = 'Lsp Info' },
    { '<Leader>;L', '<cmd>LspInstall<CR>', desc = 'Install lsp server' },
    { '<Leader>;n', '<cmd>NullLsInfo<CR>', desc = 'Null-ls Info' },
    { '<Leader>;N', '<cmd>NullLsInstall<CR>', desc = 'Install null-ls source' },
    { '<Leader>;m', '<cmd>Mason<CR>', desc = 'Mason' },
  },
}

local function on_attach(client, bufnr)
  require(PREFIX .. '.formatting').on_attach(client, bufnr)
  require(PREFIX .. '.keymaps').on_attach(client, bufnr)
  -- require(PREFIX .. '.signature').on_attach(client, bufnr)
end

spec.config = function()
  require('lspconfig.ui.windows').default_options.border = 'single'
  require(PREFIX .. '.diagnostic').setup()

  require('mason').setup()
  require(PREFIX .. '.null-ls').setup(on_attach)
  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = true,
  }

  -- require(PREFIX .. '.servers').setup(on_attach)
  require('mason-lspconfig').setup_handlers {
    function(server)
      -- setup lsp servers
      local lspconfig = require('lspconfig')
      local servers = require('plugins.lsp.servers').servers
      -- custom config in lspconfig/servers.lua
      local opts = servers[server] or {}
      local defaults = {
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }
      opts = vim.tbl_deep_extend('force', defaults, opts)
      lspconfig[server].setup(opts)
    end,
  }
end

return { spec }
