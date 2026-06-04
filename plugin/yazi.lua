vim.pack.add {
  'https://github.com/mikavilpas/yazi.nvim',
}

-- 👇 if you use `open_for_directories=true`, this is recommended.
--
-- mark netrw as loaded so it's not loaded at all.
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    require('yazi').setup {
      open_for_directories = true,
    }
  end,
})

-- set keymaps
vim.keymap.set({ 'n' }, '<c-e>', '<cmd>Yazi<cr>', {
  desc = 'Explorer yazi(cfile)',
})
vim.keymap.set({ 'n' }, '<leader>-', '<cmd>Yazi cwd<cr>', {
  desc = 'Explorer yazi(CWD)',
})
vim.keymap.set({ 'n' }, '<leader>/', '<cmd>Yazi toggle<cr>', {
  desc = 'Explorer yazi(resume)',
})
