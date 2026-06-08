vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('zenlian.util.format').setup()

require('conform').setup {
  default_format_opts = {
    timeout_ms = 1000,
    async = false,
    quiet = false,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
  },
  format_on_save = function(bufnr)
    if require('zenlian.util.format').enabled(bufnr) then
      return {}
    else
      return nil
    end
  end,
}

vim.keymap.set({ 'n', 'x' }, '<leader>lf', function()
  require('conform').format()
end, { desc = 'Format buffer/Selection' })
