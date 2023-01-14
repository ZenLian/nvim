-- vim:foldmethod=marker:foldmarker={{{,}}}:

require('config').setup()

local plugins = {
  -- TODO: maybe dont need it anymore with lazy.nvim
  -- ['lewis6991/impatient.nvim'] = {},

  ['RRethy/vim-illuminate'] = 'illuminate',

  ['nvim-telescope/telescope-file-browser.nvim'] = {
    after = 'telescope.nvim',
    config = function()
      require('telescope').load_extension('file_browser')
    end,
  },

  ['gbprod/yanky.nvim'] = 'yanky',
  ['akinsho/toggleterm.nvim'] = 'toggleterm',
  ['folke/todo-comments.nvim'] = 'todo-comments',
  ['abecodes/tabout.nvim'] = {
    after = { 'nvim-cmp', 'nvim-treesitter' },
    config = function()
      require('tabout').setup {}
    end,
  },

  ['ray-x/lsp_signature.nvim'] = { module = 'lsp_signature' },
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
  ['b0o/SchemaStore.nvim'] = {
    -- as = 'SchemaStore.nvim',
    module = 'schemastore',
    local_pkg = 'SchemaStore.nvim',
  },
  -- }}} lsp

  --- always trying something new {{{
  ['kevinhwang91/nvim-bqf'] = 'bqf',
  ['cbochs/grapple.nvim'] = 'grapple',
  --- }}}
}

return {}
