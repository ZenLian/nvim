local config = function()
  -- vim.opt.listchars:append('space:⋅')
  require('indent_blankline').setup {
    show_current_context = true,
    -- show_current_context_start = true,
    show_trailing_blankline_indent = false,
    space_char_blankline = ' ',
    use_treesitter = true,
    filetype_exclude = {
      'help',
      'packer',
      'lsp-installer',
      'NvimTree',
      'Trouble',
      'undotree',
      'alpha',
      'aerial',
      'markdown',
    },
  }
end

return {
  packer = {
    event = 'BufRead',
    config = config,
  },
}
