require('aerial').setup {
  -- Priority list of preferred backends for aerial.
  -- This can be a filetype map (see :help aerial-filetype-map)
  backends = {
    'lsp',
    'treesitter',
    'markdown',
  },
  -- Enum: persist, close, auto, global
  --   persist - aerial window will stay open until closed
  --   close   - aerial window will close when original file is no longer visible
  --   auto    - aerial window will stay open as long as there is a visible
  --             buffer to attach to
  --   global  - same as 'persist', and will always show symbols for the current buffer
  close_behavior = 'global',
  -- Enum: prefer_right, prefer_left, right, left, float
  -- Determines the default direction to open the aerial window. The 'prefer'
  -- options will open the window in the other direction *if* there is a
  -- different buffer in the way of the preferred direction
  default_direction = 'right',
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
