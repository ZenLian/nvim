local config = function()
  local spec = require('mini.ai').gen_spec
  require('mini.ai').setup {
    custom_textobjects = {
      -- whole buffer
      e = function()
        local from = { line = 1, col = 1 }
        local to = {
          line = vim.fn.line('$'),
          col = vim.fn.getline('$'):len(),
        }
        return { from = from, to = to }
      end,
      a = spec.treesitter { a = '@parameter.outer', i = '@parameter.inner' },
      f = spec.treesitter { a = '@function.outer', i = '@function.inner' },
      c = spec.treesitter { a = '@class.outer', i = '@class.inner' },
      o = spec.treesitter {
        a = { '@conditional.outer', '@loop.outer' },
        i = { '@conditional.inner', '@loop.inner' },
      },
      -- TODO: u-url, /-comment, i-indent
      C = spec.treesitter { a = '@comment.outer', i = '@comment.inner' },
      -- u = { 'https://' },
    },
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Main textobject prefixes
      -- around = 'a',
      -- inside = 'i',

      -- Next/last textobjects
      around_next = 'aj',
      inside_next = 'ij',
      around_last = 'ak',
      inside_last = 'ik',

      -- Move cursor to corresponding edge of `a` textobject
      -- goto_left = 'g[',
      -- goto_right = 'g]',
    },

    -- Number of lines within which textobject is searched
    -- n_lines = 50,
    search_method = 'cover',
  }
  -- require('mini.bufremove').setup {}
end

return { config = config }
