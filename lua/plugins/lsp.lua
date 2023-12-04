return {
  {
    'neovim/nvim-lspconfig',
    opts = function()
      require('lspconfig.ui.windows').default_options.border = 'rounded'
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },
}
