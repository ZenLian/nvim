return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'rst' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'pyright' },
      servers = {
        pyright = {},
      },
    },
  },
}
