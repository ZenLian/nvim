local on_attach = function(client, bufnr)
  require('plugins.completion.lspconfig.formatting').on_attach(client, bufnr)
  require('plugins.completion.lspconfig.keymaps').on_attach(client, bufnr)
  require('plugins.completion.lspconfig.signature').on_attach(client, bufnr)

  -- plugins hook
  require('illuminate').on_attach(client)
end

local on_server_ready = function(server)
  -- setup lsp servers
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local servers = require('plugins.completion.lspconfig.servers')
  -- custom config in lspconfig/servers.lua
  local opts = servers[server] or {}
  local defaults = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  opts = vim.tbl_deep_extend('force', defaults, opts)
  lspconfig[server].setup(opts)
end

local setup = function()
  require('plugins.completion.lspconfig.diagnostic').setup()

  require('mason').setup()
  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = true,
  }
  require('plugins.completion.lspconfig.null-ls').setup(on_attach)
  require('neodev').setup {}

  require('mason-lspconfig').setup_handlers {
    function(server)
      on_server_ready(server)
    end,
  }
end

setup()
