local spec = {
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  opts = {
    current_line_blame = false,
    current_line_blame_opts = { delay = 500, virtual_text_pos = 'eol' },
    on_attach = function(bufnr)
      -- TODO:
      -- require('config.keymaps').register_gitsigns(bufnr)
    end,
  },
}

function register_gitsigns(bufnr)
  local whichkey = require('which-key')
  -- <Leader>g
  whichkey.register({
    name = 'git',
    D = { '<cmd>lua require("gitsigns").diffthis()<CR>', 'Diff index' },
    p = { '<cmd>lua require("gitsigns").preview_hunk_inline()<CR>', 'Preview inline' },
    P = { '<cmd>lua require("gitsigns").preview_hunk()<CR>', 'Preview' },
    q = { '<cmd>lua require("gitsigns").setqflist(0)<CR>', 'Send to quickfix window' },
    b = { '<cmd>lua require("gitsigns").blame_line{full=true}<CR>', 'Git blame' },
  }, { prefix = '<Leader>g', buffer = bufnr })
  -- <Leader>g Visual
  whichkey.register({
    name = 'git',
    h = {
      -- defined by gitsigns
      name = 'hunk',
      r = { '<cmd>lua require"gitsigns.actions".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Reset hunk' },
      s = { '<cmd>lua require"gitsigns.actions".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', 'Stage hunk' },
    },
  }, { prefix = '<Leader>g', mode = 'v', buffer = bufnr })
  -- Next/Previous hunk
  whichkey.register({
    ['[g'] = {
      "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
      'Previous hunk',
      expr = true,
    },
    [']g'] = {
      "&diff ? ']h' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
      'Next hunk',
      expr = true,
    },
  }, { buffer = bufnr })
  -- Text objects
  whichkey.register({
    ['ig'] = { '<cmd>lua require("gitsigns.actions").select_hunk()<CR>', 'a hunk' },
    ['ag'] = { '<cmd>lua require("gitsigns.actions").select_hunk()<CR>', 'a hunk' },
  }, { mode = { 'o', 'x' }, buffer = bufnr })
end

return { spec }
