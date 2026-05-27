vim.pack.add({
  'https://github.com/stevearc/oil.nvim'
})

require('oil').setup({
  default_file_explorer = false,
  keymaps = {
    ['q'] = { 'actions.close', mode = 'n' },
    ['gd'] = {
      desc = 'Toggle file detail view',
      callback = function()
        detail = not detail
        if detail then
          require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          require('oil').set_columns { 'icon' }
        end
      end,
    },
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-t>'] = { 'actions.select', opts = { tab = true } },
  },
  view_options = { show_hidden = true },
  win_options = { signcolumn = "auto:2" },
})

vim.keymap.set("n", "<leader>E", "<cmd>Oil<cr>", { desc = "Explorer Oil" })
