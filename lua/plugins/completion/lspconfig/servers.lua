return {
  sumneko_lua = require('lua-dev').setup {},
  ccls = {},
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },
}
