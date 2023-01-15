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
          download_url_template = 'https://kgithub.com/%s/releases/download/%s/%s',
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
    -- 'hrsh7th/cmp-nvim-lsp',
  },
  keys = {
    { '<Leader>pl', '<cmd>LspInfo<CR>', desc = 'Lsp Info' },
    { '<Leader>pL', '<cmd>LspInstall<CR>', desc = 'Install lsp server' },
    { '<Leader>pn', '<cmd>NullLsInfo<CR>', desc = 'Null-ls Info' },
    { '<Leader>pN', '<cmd>NullLsInstall<CR>', desc = 'Install null-ls source' },
  },
}

spec.config = function()
  require('lspconfig.ui.windows').default_options.border = 'single'

  local function on_attach(client, bufnr)
    require(PREFIX .. '.formatting').on_attach(client, bufnr)
    require(PREFIX .. '.keymaps').on_attach(client, bufnr)
    -- require(PREFIX..'.signature').on_attach(client, bufnr)
  end

  require(PREFIX .. '.diagnostic').setup()
  -- require('mason').setup { }
  require(PREFIX .. '.null-ls').setup(on_attach)
  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = true,
  }
  require('mason-null-ls').setup {
    automatic_installation = true,
  }
  -- require('neodev').setup {}

  require(PREFIX .. '.servers').setup(on_attach)
  -- require('mason-lspconfig').setup_handlers {
  --   function(server)
  --     -- setup lsp servers
  --     local lspconfig = require('lspconfig')
  --     local capabilities = require('cmp_nvim_lsp').default_capabilities()
  --     local servers = require('plugins.lsp.servers')
  --     -- custom config in lspconfig/servers.lua
  --     local opts = servers[server] or {}
  --     local defaults = {
  --       on_attach = on_attach,
  --       capabilities = capabilities,
  --     }
  --     opts = vim.tbl_deep_extend('force', defaults, opts)
  --     lspconfig[server].setup(opts)
  --   end,
  -- }
end

return { spec }
