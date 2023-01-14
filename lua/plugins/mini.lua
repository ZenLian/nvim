local util = require('util')

local spec = {
  'echasnovski/mini.nvim',
  event = { 'BufWinEnter' },
}

spec.config = function()
  local gen_spec = require('mini.ai').gen_spec
  require('mini.ai').setup {
    custom_textobjects = {
      -- whole buffer
      e = function()
        local from = { line = 1, col = 1 }
        local to = {
          line = vim.api.nvim_buf_line_count(0),
          col = math.max(vim.fn.getline('$'):len(), 1),
        }
        return { from = from, to = to }
      end,
      a = gen_spec.treesitter { a = '@parameter.outer', i = '@parameter.inner' },
      f = gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
      c = gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
      o = gen_spec.treesitter {
        a = { '@conditional.outer', '@loop.outer' },
        i = { '@conditional.inner', '@loop.inner' },
      },
      -- comment
      ['/'] = gen_spec.treesitter { a = '@comment.outer', i = '@comment.inner' },
      -- TODO: u-url, i-indent
      i = function(ai_type, _, _)
        local function blank(lnum)
          local line = vim.fn.getline(lnum)
          return line:find('^%s*$') ~= nil
        end

        local lcurrent = vim.fn.line('.')
        local llast = vim.fn.line('$')
        local indent = vim.fn.indent(lcurrent)

        local filter
        if indent == 0 then
          -- all non-blank lines with no indentation
          filter = function(lnum)
            return not blank(lnum) and vim.fn.indent(lnum) == 0
          end
        elseif ai_type == 'i' then
          -- all lines with same indentation
          filter = function(lnum)
            return vim.fn.indent(lnum) >= indent
          end
        else
          -- 'a' type including blank lines
          filter = function(lnum)
            return blank(lnum) or vim.fn.indent(lnum) >= indent
          end
        end

        local lstart, lend = lcurrent, lcurrent
        for lnum = lcurrent - 1, 1, -1 do
          if not filter(lnum) then
            break
          end
          lstart = lnum
        end
        for lnum = lcurrent + 1, llast do
          if not filter(lnum) then
            break
          end
          lend = lnum
        end

        return {
          from = {
            line = lstart,
            col = 1,
          },
          to = {
            line = lend,
            col = vim.fn.col { lend, '$' } - 1,
            -- col = math.max(vim.fn.getline(lend):len(), 1),
          },
        }
      end,
      -- u = { 'https://' },
    },
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Main textobject prefixes
      around = 'a',
      inside = 'i',

      -- Next/last textobjects
      around_next = 'aj',
      inside_next = 'ij',
      around_last = 'ak',
      inside_last = 'ik',

      -- Move cursor to corresponding edge of `a` textobject
      goto_left = 'g[',
      goto_right = 'g]',
    },

    -- Number of lines within which textobject is searched
    n_lines = 5000,
    search_method = 'cover_or_next',
  }

  require('mini.bufremove').setup {}
  util.keymaps {
    ['<Leader>bd'] = {
      function()
        require('mini.bufremove').delete()
      end,
      desc = 'Delete buffer',
    },
  }
end

return { spec }
