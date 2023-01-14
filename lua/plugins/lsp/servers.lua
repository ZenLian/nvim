local M = {}

M.servers = {
  sumneko_lua = {},
  -- ccls = {},
  clangd = {},
  jsonls = {
    settings = {
      json = {
        -- schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        -- schemas = {
        --   ['https://json.schemastore.org/clang-format.json'] = '.clang-format',
        -- },
        -- TODO: not merged yet
        -- schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
}

function M.setup(on_attach)
  local lspconfig = require('lspconfig')

  local defaults = {
    on_attach = on_attach,
    capabilities = require('plugins.lsp.completion').capabilities,
  }
  for server, opts in pairs(M.servers) do
    opts = require('util').tbl_merge(defaults, opts)
    lspconfig[server].setup(opts)
  end
end

return M
