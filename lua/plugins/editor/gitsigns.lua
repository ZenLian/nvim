require('gitsigns').setup {
  keymaps = {
    buffer = true,
    noremap = true,

    ['n ]g'] = { expr = true, "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'" },
    ['n [g'] = { expr = true, "&diff ? '[h' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'" },
    ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>ghb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n <leader>ghS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>ghU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
    -- Text objects
    ['o ig'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['o ag'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ig'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ag'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  },
  current_line_blame = true,
  current_line_blame_opts = { delay = 500, virtual_text_pos = 'eol' },
}
