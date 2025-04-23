---@type LazyPluginSpec[]
return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'folke/which-key.nvim',
        opts = {
          icons = {
            rules = {
              { plugin = 'harpoon', icon = '󰒤', color = 'azure' },
            },
          },
        },
      },
    },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          '<leader>H',
          function()
            local harpoon = require('harpoon')
            harpoon:list():add()
          end,
          desc = 'Harpoon Add File',
        },
        {
          '<leader>h',
          function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = 'Harpoon Quick Menu',
        },
      }
      for i = 1, 5 do
        table.insert(keys, {
          '<leader>' .. i,
          function()
            local harpoon = require('harpoon')
            harpoon:list():select(i)
          end,
          desc = 'Harpoon to File ' .. i,
        })
      end
      return keys
    end,
    config = function(_, opts)
      local harpoon = require('harpoon')
      harpoon:setup(opts)

      -- Highlight current file in the harpoon buffer list
      local harpoon_extensions = require('harpoon.extensions')
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

      -- add keymaps for opening files in splits & tabs.
      harpoon:extend {
        UI_CREATE = function(cx)
          vim.keymap.set('n', '<C-v>', function()
            harpoon.ui:select_menu_item { vsplit = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-x>', function()
            harpoon.ui:select_menu_item { split = true }
          end, { buffer = cx.bufnr })

          vim.keymap.set('n', '<C-t>', function()
            harpoon.ui:select_menu_item { tabedit = true }
          end, { buffer = cx.bufnr })
        end,
      }
    end,
  },
}
