return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern(
              'compile_commands.json',
              'compile_flags.txt',
              -- 'Makefile',
              'configure.ac',
              -- 'configure.in',
              'config.h.in',
              'meson.build',
              'meson_options.txt',
              'build.ninja',
              '.clangd',
              '.root'
            )(fname) or require('lspconfig.util').find_git_ancestor(fname)
          end,
        },
      },
    },
  },
}
