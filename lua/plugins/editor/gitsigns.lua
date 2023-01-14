local spec = {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = function()
    local util = require('util')
    local gitsigns = require('gitsigns')
    local opts = {
      current_line_blame = false,
      current_line_blame_opts = { delay = 500, virtual_text_pos = 'eol' },
      on_attach = function(bufnr)
        util.keymaps({
          ['<Leader>g'] = {
            ['hs'] = {
              ':Gitsigns stage_hunk<CR>',
              desc = 'Stage hunk',
            },
            ['hr'] = {
              ':Gitsigns reset_hunk<CR>',
              desc = 'Reset hunk',
            },
          },
        }, { mode = { 'n', 'v' }, buffer = bufnr })

        -- normal maps
        util.keymaps({
          ['<Leader>g'] = {
            ['hu'] = { gitsigns.undo_stage_hunk, desc = 'Undo stage hunk' },
            ['hS'] = { gitsigns.stage_buffer, desc = 'Stage buffer' },
            ['hR'] = { gitsigns.reset_buffer, desc = 'Reset buffer' },
            ['hp'] = { gitsigns.preview_hunk_inline, desc = 'Preview inline' },
            ['hP'] = { gitsigns.preview_hunk, desc = 'Preview' },
            ['d'] = { gitsigns.diffthis, desc = 'Diff index' },
            ['q'] = { '<cmd>lua require("gitsigns").setqflist(0)<CR>', desc = 'Send to quickfix window' },
            ['b'] = { '<cmd>lua require("gitsigns").blame_line{full=true}<CR>', desc = 'Git blame' },
          },
          ['[g'] = {
            function()
              if vim.wo.diff then
                return '[g'
              end
              vim.schedule(gitsigns.prev_hunk)
              return '<Ignore>'
            end,
            desc = 'Previous hunk',
            expr = true,
          },
          [']g'] = {
            function()
              if vim.wo.diff then
                return ']g'
              end
              vim.schedule(gitsigns.next_hunk)
              return '<Ignore>'
            end,
            desc = 'Next hunk',
            expr = true,
          },
        }, { buffer = bufnr })

        -- Text objects
        util.keymaps({
          ['ig'] = { ':<C-u>Gitsigns select_hunk<CR>', desc = 'a hunk' },
          ['ag'] = { ':<C-u>Gitsigns select_hunk<CR>', desc = 'a hunk' },
        }, { mode = { 'o', 'x' }, buffer = bufnr })
      end,
    }
    return opts
  end,
}

return { spec }
