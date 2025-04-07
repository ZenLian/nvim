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
        if require('zenlian.util.format').enabled(bufnr) then
          return {}
        else
          return nil
        end
      end,
    },
    init = function()
      require('zenlian.util.format').init()
    end,
  },
}
