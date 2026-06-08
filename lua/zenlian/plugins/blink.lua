vim.pack.add {
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp',
  'https://github.com/rafamadriz/friendly-snippets',
  -- sources
  'https://github.com/moyiz/blink-emoji.nvim',
  'https://github.com/MahanRahmati/blink-nerdfont.nvim',
}

-- https://github.com/saghen/blink.cmp/discussions/2502
-- shims for sources that only support v1
package.loaded['blink.cmp.lib.async'] = (function()
  local task = require('blink.lib.task')
  task.empty = task.resolve
  task.on_completion = task.on_resolve
  task.on_failure = task.on_reject
  task.task = task
  return task
end)()

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup {
  cmdline = {
    enabled = true,
    keymap = {
      ['<Tab>'] = { 'show', 'accept' },
    },
    completion = { menu = { auto_show = true } },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = true,
    },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  keymap = { preset = 'super-tab' },
  signature = {
    enabled = true,
  },
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
      -- custom sources
      'emoji',
      'nerdfont',
    },
    providers = {
      emoji = {
        module = 'blink-emoji',
        name = 'Emoji',
        score_offset = 15, -- Tune by preference
        opts = {
          insert = true, -- Insert emoji (default) or complete its name
          ---@type string|table|fun():table
          trigger = ':',
        },
        -- should_show_items = function()
        --   return vim.tbl_contains(
        --     -- Enable emoji completion only for git commits and markdown.
        --     -- By default, enabled for all file-types.
        --     { 'gitcommit', 'markdown' },
        --     vim.o.filetype
        --   )
        -- end,
      },
      nerdfont = {
        module = 'blink-nerdfont',
        name = 'Nerd Fonts',
        score_offset = 15, -- Tune by preference
        opts = {
          insert = true, -- Insert nerdfont icon (default) or complete its name
          trigger = ':', -- Customize the trigger. Defaults to ":"
        },
      },
    },
  },
  snippets = { preset = 'default' },
}
