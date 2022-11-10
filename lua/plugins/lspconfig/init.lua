local config = function()
  local function lspconfig_setup()
    require('lspconfig.ui.windows').default_options.border = 'single'
  end

  local function on_attach(client, bufnr)
    require('plugins.lspconfig.formatting').on_attach(client, bufnr)
    require('plugins.lspconfig.keymaps').on_attach(client, bufnr)
    require('plugins.lspconfig.signature').on_attach(client, bufnr)

    -- plugins hook
    require('illuminate').on_attach(client)
  end

  local function on_server_ready(server)
    -- setup lsp servers
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local servers = require('plugins.lspconfig.servers')
    -- custom config in lspconfig/servers.lua
    local opts = servers[server] or {}
    local defaults = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    opts = vim.tbl_deep_extend('force', defaults, opts)
    lspconfig[server].setup(opts)
  end

  require('mason').setup {
    github = {
      download_url_template = 'https://kgithub.com/%s/releases/download/%s/%s',
    },
    ui = {
      border = 'single',
    },
  }
  require('plugins.lspconfig.null-ls').setup(on_attach)
  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = true,
  }
  require('mason-null-ls').setup {
    automatic_installation = true,
  }
  require('neodev').setup {}
  require('mason-lspconfig').setup_handlers {
    function(server)
      on_server_ready(server)
    end,
  }

  lspconfig_setup()
  require('plugins.lspconfig.diagnostic').setup()
end

return { config = config }
