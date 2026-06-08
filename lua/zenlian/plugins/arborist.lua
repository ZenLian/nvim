vim.pack.add { 'https://github.com/arborist-ts/arborist.nvim' }
require('arborist').setup {
  prefer_wasm = true,
  install_popular = true,
  ensure_installed = {
    'cmake',
    'markdown',
    'latex',
  },
}
