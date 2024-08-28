return {
  -- auto completion
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require('cmp')

      LazyVim.merge(opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      })

      opts.sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
      }, {
        name = 'buffer',
        option = {
          -- all buffers smaller than 1MB
          get_bufnrs = function()
            local bufnrs = vim.tbl_filter(function(buf)
              local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
              return fsize < 1024 * 1024
            end, vim.api.nvim_list_bufs())
            return bufnrs
          end,
        },
      })

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
  -- {
  -- 'echasnovski/mini.comment',
  -- FIXME: unmap default <C-/>
  -- keys = {
  --   { '<C-_>', 'gcc', mode = 'n', desc = 'Comment', remap = true },
  --   { '<C-_>', 'gc', mode = 'v', desc = 'Comment', remap = true },
  -- },
  -- },

  -- telescope
  -- {
  --   'nvim-telescope/telescope.nvim',
  --   dependencies = {
  --     { 'nvim-telescope/telescope-symbols.nvim' },
  --   },
  -- keys = {
  --   { '<leader>s;', Util.pick.telescope('symbols'), desc = 'Symbols' },
  -- },
  -- },

  -- [NEW] dial.nvim
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
