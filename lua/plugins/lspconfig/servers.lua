return {
  sumneko_lua = {},
  -- ccls = {},
  clangd = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
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
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },
}
