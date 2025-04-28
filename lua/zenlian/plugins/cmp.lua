return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '*',
    event = 'InsertEnter',
    opts = {
      keymap = { preset = 'super-tab' },
      cmdline = {
        enabled = false,
        keymap = {
          ['<Tab>'] = { 'show', 'accept' },
        },
        completion = { menu = { auto_show = true } },
      },
      appearance = {
        -- 'mono' or 'normal'
        nerd_font_variant = 'mono',
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          auto_show = true,
          draw = {
            treesitter = { 'lsp' },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      snippets = { preset = 'default' },
      signature = { enabled = true },
      fuzzy = { implementation = 'prefer_rust' },
    },
    opts_extend = { 'sources.default' },
  },
}
