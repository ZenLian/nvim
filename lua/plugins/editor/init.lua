local editor = {}

editor['nvim-treesitter/nvim-treesitter'] = {
  opt = true,
  run = ':TSUpdate',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('plugins.editor.treesitter')
  end,
}
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
  opt = true,
  after = 'nvim-treesitter',
}
editor['nvim-treesitter/playground'] = {
  opt = true,
  cmd = 'TSPlaygroundToggle',
}
-- 代码块高亮很碍眼，当前单词高亮还行，以后需要再配置
--editor["nvim-treesitter/nvim-treesitter-refactor"] = {
--    opt = true,
--    after = "nvim-treesitter"
--}
editor['lewis6991/nvim-treesitter-context'] = {
  opt = true,
  after = 'nvim-treesitter',
}

editor['p00f/nvim-ts-rainbow'] = {
  opt = true,
  after = 'nvim-treesitter',
}

editor['numToStr/Comment.nvim'] = {
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('Comment').setup {
      -- ignore blank lines
      ignore = '^(%s*)$',
    }
  end,
}

editor['mfussenegger/nvim-treehopper'] = {
  opt = true,
  after = 'nvim-treesitter',
  config = function()
    require('plugins.editor.treehopper')
  end,
}

editor['ur4ltz/surround.nvim'] = {
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('surround').setup { mappings_style = 'surround' }
  end,
}

editor['ggandor/leap.nvim'] = {
  config = function()
    require('plugins.editor.leap')
  end,
}

editor['ggandor/flit.nvim'] = {
  config = function()
    require('flit').setup {}
  end,
  after = { 'leap.nvim' },
}

editor['ggandor/leap-spooky.nvim'] = {
  config = function()
    require('leap-spooky').setup {}
  end,
  after = { 'leap.nvim' },
}

editor['abecodes/tabout.nvim'] = {
  config = function()
    require('tabout').setup {}
  end,
  after = { 'nvim-cmp', 'nvim-treesitter' },
}

editor['lewis6991/gitsigns.nvim'] = {
  opt = true,
  event = { 'BufRead', 'BufNewFile' },
  requires = { 'nvim-lua/plenary.nvim', opt = false },
  config = function()
    require('plugins.editor.gitsigns')
  end,
}

editor['gpanders/editorconfig.nvim'] = {
  opt = true,
  event = { 'BufRead', 'BufNewFile' },
}

return editor
