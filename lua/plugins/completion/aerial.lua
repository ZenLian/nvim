require('aerial').setup {
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = {
    'lsp',
    'treesitter',
    'markdown',
  },
  -- A list of all symbols to display. Set to false to display all symbols.
  -- This can be a filetype map (see :help aerial-filetype-map)
  -- To see all available values, see :help SymbolKind
  filter_kind = false,
  --     "Class",
  --     "Constructor",
  --     "Enum",
  --     "Function",
  --     "Interface",
  --     "Module",
  --     "Method",
  --     "Struct",
  -- },
  highlight_on_hover = true,
  manage_folds = true,
  min_width = 20,
  show_guides = true,
}
