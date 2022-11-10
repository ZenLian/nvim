-- FIXME:
-- capabilities = require('cmp_nvim_lsp').default_capabilities(),
-- causing no syntax highlighting with treesitter when open first buffer
return {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          deprecatedSupport = true,
          commitCharactersSupport = true,
          tagSupport = { valueSet = { 1 } },
          resolveSupport = {
            properties = {
              'documentation',
              'detail',
              'additionalTextEdits',
            },
          },
        },
      },
    },
  },
}
