local config = function()
  require('persisted').setup {
    -- autosave = false,
    before_save = function()
      pcall(vim.cmd, 'Neotree close')
    end,
    after_save = function()
      print('Session saved!')
    end,
    before_source = function()
      print('Sesson sourcing...')
    end,
    -- after_source = function()
    --   -- Reload the LSP servers
    --   vim.lsp.stop_client(vim.lsp.get_active_clients())
    -- end,
  }
  require('telescope').load_extension('persisted') -- To load the telescope extension
end

return { config = config }
