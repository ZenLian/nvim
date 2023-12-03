local Util = require('lazyvim.util')

return {
  -- snippets
  {
    'L3MON4D3/LuaSnip',
    -- disable default keymaps
    keys = function()
      return {}
    end,
  },
  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end
      local termcodes = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      opts.mapping = cmp.mapping.preset.insert {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<S-CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-CR>'] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ['<C-k>'] = function(fallback)
          if require('luasnip').jumpable(-1) then
            vim.fn.feedkeys(termcodes('<Plug>luasnip-jump-prev'), '')
          else
            fallback()
          end
        end,
        ['<C-j>'] = function(fallback)
          if require('luasnip').expand_or_jumpable() then
            vim.fn.feedkeys(termcodes('<Plug>luasnip-expand-or-jump'), '')
          else
            fallback()
          end
        end,
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      }

      -- opts.sources = cmp.config.sources {
      --   {
      --     { name = 'nvim_lsp' },
      --     { name = 'luasnip' },
      --     { name = 'path' },
      --   },
      --   {
      --     {
      --       name = 'buffer',
      --       option = {
      --         -- all buffers smaller than 1MB
      --         get_bufnrs = function()
      --           local bufnrs = vim.tbl_filter(function(buf)
      --             local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
      --             return fsize < 1024 * 1024
      --           end, vim.api.nvim_list_bufs())
      --           return bufnrs
      --         end,
      --         -- visible buffer
      --         -- get_bufnrs = function()
      --         --   local bufs = {}
      --         --   for _, win in ipairs(vim.api.nvim_list_wins()) do
      --         --     bufs[vim.api.nvim_win_get_buf(win)] = true
      --         --   end
      --         --   return vim.tbl_keys(bufs)
      --         -- end,
      --       },
      --     },
      --   },
      -- }
      --
      -- opts.sorting = {
      --   comparators = {
      --     --> https://github.com/hrsh7th/cmp-buffer#locality-bonus-comparator-distance-based-sorting
      --     function(...)
      --       return require('cmp_buffer'):compare_locality(...)
      --     end,
      --   },
      -- }
    end,
  },

  -- comment
  {
    'echasnovski/mini.comment',
    -- FIXME: unmap default <C-/>
    -- keys = {
    --   { '<C-_>', 'gcc', mode = 'n', desc = 'Comment', remap = true },
    --   { '<C-_>', 'gc', mode = 'v', desc = 'Comment', remap = true },
    -- },
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-telescope/telescope-symbols.nvim' },
    },
    keys = {
      { '<leader>s;', Util.telescope('symbols'), desc = 'Symbols' },
    },
  },

  -- add dial.nvim
  {
    'monaqa/dial.nvim',
    keys = {
      -- stylua: ignore start
      { '<C-a>', function() return require('dial.map').inc_normal() end, mode='n', desc = 'Dial Increase', expr = true },
      { '<C-x>', function() return require('dial.map').dec_normal() end, mode='n', desc = 'Dial Decrease', expr = true },
      { '<C-a>', function() return require('dial.map').inc_visual() end, mode = 'v', desc = 'Dial Increase', expr = true },
      { '<C-x>', function() return require('dial.map').dec_visual() end, mode = 'v', desc = 'Dial Decrease', expr = true },
      { 'g<C-a>', function() return require('dial.map').inc_gvisual() end, mode = 'v', desc = 'Dial Increase', expr = true },
      { 'g<C-x>', function() return require('dial.map').dec_gvisual() end, mode = 'v', desc = 'Dial Decrease', expr = true },
      -- stylua: ignore end
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.integer.alias.octal,
          augend.integer.alias.binary,
          -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
          augend.integer.new {
            radix = 16,
            prefix = '0x',
            natural = true,
            case = 'upper',
          },
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.date.alias['%m/%d'],
          augend.date.alias['%H:%M'],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.constant.alias.bool,
          augend.constant.alias.de_weekday_full,
          augend.constant.new {
            elements = { 'and', 'or' },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          },
          augend.constant.new {
            elements = { '&&', '||' },
            word = false,
            cyclic = true,
          },
        },
        -- typescript = {
        --   augend.integer.alias.decimal,
        --   augend.integer.alias.hex,
        --   augend.constant.new { elements = { 'let', 'const' } },
        -- },
      }
    end,
  },
}
