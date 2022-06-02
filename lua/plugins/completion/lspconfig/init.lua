local on_attach = function(client, bufnr)
  require('plugins.completion.lspconfig.formatting').on_attach(client, bufnr)
  require('plugins.completion.lspconfig.keymaps').on_attach(client, bufnr)
  require('plugins.completion.lspconfig.signature').on_attach(client, bufnr)

  -- plugins hook
  require('aerial').on_attach(client, bufnr)
  require('illuminate').on_attach(client)
end

local setup = function()
  require('plugins.completion.lspconfig.diagnostic').setup()

  -- setup lsp installer
  local servers = require('plugins.completion.lspconfig.servers')
  require('nvim-lsp-installer').setup {
    -- ensure_installed = vim.tbl_keys(servers),
  }

  -- setup lsp servers
  require('plugins.completion.lspconfig.null-ls').setup(on_attach)
  local lspconfig = require('lspconfig')
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  for server, opts in pairs(servers) do
    local defaults = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend('force', defaults, opts)

    -- custom config in lspconfig/{server}.lua
    lspconfig[server].setup(opts)
  end
end

setup()
