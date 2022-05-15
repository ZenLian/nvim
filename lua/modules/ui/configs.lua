local configs = {}

configs.colorscheme = function()
    vim.o.background = 'dark'
    require('edgeme').setup {
        style = 'aura',
    }
    vim.cmd [[colorscheme edgeme]]
end

configs.windline = function()
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
    require('indent_blankline').setup {
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
