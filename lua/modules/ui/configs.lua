local configs = {}

configs.edge = function()
    vim.o.background = 'dark'
    vim.g.edge_style = 'aura'
    --vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_better_performance = 1
    vim.cmd [[colorscheme edge]]
end

configs.vscode = function ()
    vim.o.background = 'dark'
    vim.g.vscode_style = 'dark'
    vim.g.vscode_transparent = 0
    vim.g.vscode_italic_comment = 1
    vim.g.vscode_disable_nvimtree_bg = false
    vim.cmd [[colorscheme vscode]]
end

configs.windline = function ()
    require('modules.ui.windline.evil_line').setup()
    require('wlfloatline').setup()
end

configs.bufferline = function()
    require('bufferline').setup {
        highlights = {
            buffer_selected = {
                gui = "italic"
            },
        }
    }
end

configs.indent_blankline = function()
    -- vim.opt.listchars:append('space:⋅')
    require('indent_blankline').setup{
        -- show_current_context_start = true,
        -- space_char_blankline = " "
        filetype_exclude = { "help", "NvimTree", "lsp-installer", "packer" }
    }
end

configs.zen_mode = function()
    require('zen-mode').setup {
        window = {
            width = 120
        }
    }
end

return configs
