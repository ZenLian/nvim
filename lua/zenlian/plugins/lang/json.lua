return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'jsonls' },
      servers = {
        jsonls = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },
  },
}
