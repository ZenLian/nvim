local M = {
  'akinsho/toggleterm.nvim',
  packer = {
    module = 'toggleterm',
    cmd = 'ToggleTerm',
    keys = { [[<C-\>]] },
  },
}

M.packer.config = function()
  require('toggleterm').setup {
    open_mapping = [[<c-\>]],
    -- hide_numbers = true, -- hide the number column in toggleterm buffers
    -- shade_filetypes = {},
    -- shade_terminals = true,
    -- start_in_insert = true,
    -- insert_mappings = true, -- whether or not the open mapping applies in insert mode
    -- persist_size = true,
    -- direction = "vertical",
    -- close_on_exit = true, -- close the terminal window when the process exits
    -- shell = vim.o.shell, -- change the default shell
    -- on_open = function()
    --     vim.wo.winhl = "Normal:Terminal"
    -- end
  }
  -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua LazygitToggle()<CR>", {noremap = true, silent = true})
  local function set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
  end

  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  -- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  vim.api.nvim_create_autocmd({ 'TermOpen' }, {
    pattern = 'term://*',
    callback = set_terminal_keymaps,
  })
end

return M
