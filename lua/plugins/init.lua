-- vim:foldmethod=marker:foldmarker={{{,}}}:

-- additional options
--
-- disable: boolean
--   disable this plugin
--
-- is_local: boolean
--   local plugin
--
-- config = boolean | string | function
--   'name': load config from 'plugins/name.lua'
--   true: auto parse plugin name
--   function: same as packer
--
-- keymaps = table
--   keymap table
--
local plugins = {
  --{{{ requirements
  ['nvim-lua/plenary.nvim'] = { module = 'plenary' },
  ['MunifTanjim/nui.nvim'] = { module = 'nui' },
  ['kkharji/sqlite.lua'] = { module = 'sqlite' },
  ['nvim-tree/nvim-web-devicons'] = 'web-devicons',
  ---}}} requirements

  ['lewis6991/impatient.nvim'] = {},

  -- {{{ ui
  ['catppuccin/nvim'] = 'catppuccin',
  ['rebelot/heirline.nvim'] = 'heirline',
  ['akinsho/bufferline.nvim'] = 'bufferline',
  ['goolord/alpha-nvim'] = 'alpha',
  ['rcarriga/nvim-notify'] = 'notify',
  ['stevearc/dressing.nvim'] = 'dressing',
  ['lukas-reineke/indent-blankline.nvim'] = 'indent-blankline',
  ['uga-rosa/ccc.nvim'] = 'ccc',
  ['RRethy/vim-illuminate'] = 'illuminate',
  ['Pocco81/true-zen.nvim'] = 'true-zen',
  ['folke/twilight.nvim'] = 'twilight',
  ['kevinhwang91/nvim-ufo'] = 'ufo',
  -- }}} ui

  -- {{{ telescope
  ['nvim-telescope/telescope.nvim'] = 'telescope',
  ['nvim-telescope/telescope-fzf-native.nvim'] = {
    run = 'make',
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  ['nvim-telescope/telescope-frecency.nvim'] = {
    requires = { 'kkharji/sqlite.lua' },
    after = 'telescope.nvim',
  },
  ['nvim-telescope/telescope-symbols.nvim'] = {
    after = 'telescope.nvim',
  },
  ['nvim-telescope/telescope-file-browser.nvim'] = {
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('file_browser')
    end,
  },
  -- }}} telescope

  -- {{{ file management
  ['nvim-neo-tree/neo-tree.nvim'] = 'neo-tree',
  ['theblob42/drex.nvim'] = 'drex',
  ['ahmedkhalf/project.nvim'] = {
    config = require('project_nvim').setup {},
  },
  --}}}

  -- {{{ git tools
  ['lewis6991/gitsigns.nvim'] = 'gitsigns',
  ['TimUntersberger/neogit'] = 'neogit',
  ['sindrets/diffview.nvim'] = {
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    module = 'diffview',
  },
  -- }}}

  ['gbprod/yanky.nvim'] = 'yanky',
  ['akinsho/toggleterm.nvim'] = 'toggleterm',
  ['folke/todo-comments.nvim'] = 'todo-comments',
  ['folke/which-key.nvim'] = 'which-key',
  ['anuvyklack/hydra.nvim'] = 'hydra',
  -- {
  --   'jiaoshijie/undotree',
  --   module = 'undotree',
  --   config = function()
  --     require('undotree').setup()
  --   end,
  -- },
  -- use vim-startuptime shell cmd(written in go)
  -- {
  --   'dstein64/vim-startuptime',
  --   cmd = 'StartupTime',
  -- },

  --- treesitter {{{
  ['nvim-treesitter/nvim-treesitter'] = 'treesitter',
  ['nvim-treesitter/nvim-treesitter-textobjects'] = {
    after = 'nvim-treesitter',
  },
  ['nvim-treesitter/playground'] = {
    cmd = 'TSPlaygroundToggle',
  },
  ['lewis6991/nvim-treesitter-context'] = {
    after = 'nvim-treesitter',
  },
  ['mfussenegger/nvim-treehopper'] = {
    module = 'tsht',
    config = function()
      require('tsht').config.hint_keys = { 'j', 'k', 'l', 'f', 'd', 's', 'w', 'e', 'i', 'm' }
    end,
  },
  ['ziontee113/syntax-tree-surfer'] = 'syntax-tree-surfer',
  -- }}} treesitter

  ['p00f/nvim-ts-rainbow'] = {
    opt = true,
    after = 'nvim-treesitter',
  },

  -- editing {{{
  ['numToStr/Comment.nvim'] = {
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('Comment').setup()
    end,
  },
  -- {
  --   'ur4ltz/surround.nvim',
  --   event = { 'BufRead', 'BufNewFile' },
  --   config = function()
  --     require('surround').setup { mappings_style = 'surround' }
  --   end,
  -- },
  ['kylechui/nvim-surround'] = {
    event = { 'BufRead', 'BufNewFile' },
    config = function()
      require('nvim-surround').setup {}
    end,
  },
  ['ggandor/leap.nvim'] = 'leap',
  ['ggandor/flit.nvim'] = 'flit',
  -- TODO: conflicts with yanky
  -- {
  --   'ggandor/leap-spooky.nvim',
  --   after = { 'leap.nvim' },
  --   config = function()
  --     require('leap-spooky').setup()
  --   end,
  -- },
  ['abecodes/tabout.nvim'] = {
    after = { 'nvim-cmp', 'nvim-treesitter' },
    config = function()
      require('tabout').setup {}
    end,
  },
  ['monaqa/dial.nvim'] = 'dial',
  -- }}}

  ['gpanders/editorconfig.nvim'] = {
    event = { 'BufRead', 'BufNewFile' },
  },

  ['hrsh7th/nvim-cmp'] = 'cmp',
  ['L3MON4D3/LuaSnip'] = 'luasnip',
  ['windwp/nvim-autopairs'] = 'autopairs',
  ['echasnovski/mini.nvim'] = 'mini',

  -- lsp {{{
  ['neovim/nvim-lspconfig'] = 'lspconfig',
  ['williamboman/mason.nvim'] = { module = 'mason' },
  ['williamboman/mason-lspconfig.nvim'] = { module = 'mason-lspconfig' },
  ['ray-x/lsp_signature.nvim'] = { module = 'lsp_signature' },
  ['folke/neodev.nvim'] = { module = 'neodev' },
  ['jose-elias-alvarez/null-ls.nvim'] = { module = 'null-ls' },
  ['jayp0521/mason-null-ls.nvim'] = { module = 'mason-null-ls' },

  ['stevearc/aerial.nvim'] = 'aerial',
  ['folke/trouble.nvim'] = {
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = 'Trouble',
    module = 'trouble',
    config = function()
      require('trouble').setup {
        autoclose = true,
      }
    end,
  },
  ['SchemaStore.nvim'] = {
    -- 'b0o/schemastore.nvim',
    module = 'schemastore',
    is_local = true,
  },
  -- }}} lsp

  -- language specific {{{
  -- markdown {{{
  ['ellisonleao/glow.nvim'] = 'glow',
  ['toppair/peek.nvim'] = 'peek',
  ['AckslD/nvim-FeMaco.lua'] = 'femaco',
  -- }}}
  --
  -- }}}

  --- always trying something new {{{
  ['kevinhwang91/nvim-bqf'] = 'bqf',
  ['cbochs/grapple.nvim'] = 'grapple',
  ['rafcamlet/nvim-luapad'] = 'luapad',
  --- }}}
}

return {
  setup = function()
    require('util.packer').setup(plugins)
  end,
}
