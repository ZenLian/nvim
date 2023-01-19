local M = {}

-- TODO: move somewhere else
local schemas = {}
local function get_schema(name)
  if not schemas[name] then
    schemas[name] = require('schemastore')[name].schemas()
  end
  return schemas[name]
end

M.servers = {
  sumneko_lua = {
    workspace = {
      checkThirdParty = false,
    },
  },
  -- ccls = {},
  clangd = {},
  jsonls = {
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, get_schema('json'))
    end,
    settings = {
      json = {
        -- schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
  yamlls = {
    -- lazy-load schemastore when needed
    on_new_config = function(new_config)
      new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
      vim.list_extend(new_config.settings.yaml.schemas, get_schema('yaml'))
    end,
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
