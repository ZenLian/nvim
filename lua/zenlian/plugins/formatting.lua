return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>lf',
        function()
          require('conform').format()
        end,
        mode = { 'n', 'x' },
        desc = 'Format buffer',
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 1000,
        async = false,
        quiet = false,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {},
      format_on_save = function(bufnr)
        if vim.b[bufnr].zl_autoformat == false then
          return nil
        end
        if vim.b[bufnr].zl_autoformat == true then
          return {}
        end
        if vim.g.zl_autoformat then
          return {}
        else
          return nil
        end
      end,
    },
    init = function()
      vim.g.zl_autoformat = true
      require('zenlian.util').on_user_event('VeryLazy', function()
        Snacks.toggle({
          id = 'vim.g.zl_autoformat',
          name = 'Format On Save (Global)',
          get = function()
            return vim.g.zl_autoformat
          end,
          set = function(state)
            vim.g.zl_autoformat = state
          end,
        }):map('<leader>\\f')
        Snacks.toggle({
          id = 'vim.b.zl_autoformat',
          name = 'Format On Save (Buffer)',
          get = function()
            if vim.b.zl_autoformat == nil then
              return true
            end
            return vim.b.zl_autoformat
          end,
          set = function(state)
            vim.b.zl_autoformat = state
          end,
        }):map('<leader>\\F')
      end)
    end,
  },
}
