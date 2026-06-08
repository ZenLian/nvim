-- libs
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

require('zenlian.plugins.arborist')

-- Editing
require('zenlian.plugins.flash')
require('zenlian.plugins.mini-icons')
require('zenlian.plugins.mini-ai')
require('zenlian.plugins.mini-pairs')
require('zenlian.plugins.mini-surround')
require('zenlian.plugins.rainbow-delimiters')

-- Coding
-- completion
require('zenlian.plugins.blink')
-- formatting
require('zenlian.plugins.conform')
-- others
require('zenlian.plugins.neogen')

-- File Explorers
require('zenlian.plugins.yazi')
require('zenlian.plugins.neo-tree')
require('zenlian.plugins.oil')
require('zenlian.plugins.harpoon')
-- Git
require('zenlian.plugins.gitsigns')
require('zenlian.plugins.diffview')
require('zenlian.plugins.neogit')
-- Fuzzy picker
require('zenlian.plugins.fzf')
-- Utils
require('zenlian.plugins.snacks')
require('zenlian.plugins.which-key')
require('zenlian.plugins.mason')

-- Languages
require('zenlian.plugins.lazydev') -- lua
require('zenlian.plugins.markdown')

-- UI
require('zenlian.plugins.colorscheme')
require('zenlian.plugins.heirline')
