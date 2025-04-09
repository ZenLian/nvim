return {
  { 'folke/lazy.nvim', version = '*' },
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.g.snacks_animate = false
      require('zenlian.util').on_user_event('VeryLazy', function()
        Snacks.toggle.option('wrap', { name = 'Word Wrap' }):map('<leader>\\w')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>\\L')

        Snacks.toggle.line_number():map('<leader>\\l')
        Snacks.toggle.indent():map('<leader>\\i')
        Snacks.toggle.dim():map('<leader>\\d')
        Snacks.toggle.zen():map('<leader>\\z')
        Snacks.toggle.words():map('<leader>\\W')

        Snacks.toggle.diagnostics():map('<leader>\\x')
      end)
    end,
    opts = {
      bigfile = { enabled = true },
      -- quickfile = { enabled = true },
      indent = { enabled = true },
      words = {
        enabled = true,
      },
      zen = {
        toggles = {
          dim = false,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = false,
          inlay_hints = false,
        },
      },
      toggle = {
        color = {
          enabled = 'green',
          disabled = 'white',
        },
        wk_desc = {
          enabled = '',
          disabled = '',
        },
      },
      styles = {
        zen = {
          backdrop = { transparent = false, blend = 75 },
        },
      },
    },
  },
}
