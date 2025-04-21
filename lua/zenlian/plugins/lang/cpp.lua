return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'cpp' } },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      ensure_installed = { 'clangd' },
      servers = {
        clangd = {
          keys = {
            { '<leader>lo', '<cmd>ClangdSwitchSourceHeader<cr>', desc = 'Switch Source/Header (C/C++)' },
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=never',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
        },
      },
    },
  },
}
