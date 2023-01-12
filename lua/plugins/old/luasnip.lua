local M = {
  packer = {
    after = 'nvim-cmp',
    requires = { 'rafamadriz/friendly-snippets' },
  },
}

M.packer.config = function()
  require('luasnip').setup {
    history = true,
    updateevents = 'TextChanged,TextChangedI',
  }
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_snipmate').lazy_load()
end

return M
