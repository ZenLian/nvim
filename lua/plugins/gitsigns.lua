local M = {
  packer = {
    event = { 'BufRead', 'BufNewFile' },
  },
}

M.packer.config = function()
  require('gitsigns').setup {
    current_line_blame = false,
    current_line_blame_opts = { delay = 500, virtual_text_pos = 'eol' },
    on_attach = function(bufnr)
      require('config.keymaps').register_gitsigns(bufnr)
    end,
  }
end

return M
