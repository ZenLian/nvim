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

      for _, source in ipairs(opts.sources) do
        if source.name == 'buffer' then
          source.option = {
            -- all buffers smaller than 1MB
            get_bufnrs = function()
              local bufnrs = vim.tbl_filter(function(buf)
                local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
                return fsize < 1024 * 1024
              end, vim.api.nvim_list_bufs())
              return bufnrs
            end,
          }
        end
      end

      -- opts.sources.opts.sources = cmp.config.sources({
      --   { name = 'nvim_lsp' },
      --   { name = 'path' },
      -- }, {
      --   {
      --     name = 'buffer',
      --   },
      -- })

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
}
