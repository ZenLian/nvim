-- vim.opt.listchars:append('space:⋅')
require('indent_blankline').setup {
    -- show_current_context_start = true,
    -- space_char_blankline = " "
    filetype_exclude = { "help", "NvimTree", "lsp-installer", "packer" }
}
