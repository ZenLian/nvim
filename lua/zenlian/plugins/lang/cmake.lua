return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'cmake' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'cmake' },
    },
  },
}
