local keymap = vim.api.nvim_set_keymap
local configs = {}

configs['sainnhe/edge'] = function()
    vim.cmd [[set background=dark]]
    vim.g.edge_style = 'aura'
    --vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_better_performance = 1
    vim.cmd [[colorscheme edge]]
end
configs['tomasiser/vim-code-dark'] = function()
    -- vim.cmd [[colorscheme codedark]]
end

configs['nvim-lualine/lualine.nvim'] = function()
    require('lualine').setup {
        options = {
            icons_enabled = true,
            component_separators = '',
            section_separators = '',
            disabled_filetypes = {'toggleterm'}
        },
        sections = {
            lualine_a = {
                { 'mode', fmt = function(str) return str:sub(1,1) end }
            },
        },
        extentions = {
            'nvim-tree',
            'toggleterm'
        }
    }
end

configs['akinsho/nvim-bufferline.lua'] = function()
    require('bufferline').setup {
        highlights = {
            buffer_selected = {
                gui = "italic"
            },
        }
    }
end

configs['lukas-reineke/indent-blankline.nvim'] = function()
    vim.opt.listchars:append('space:⋅')
    require('indent_blankline').setup{
        space_char_blankline = " "
    }
end

configs['folke/zen-mode.nvim'] = function()
    require('zen-mode').setup {
        window = {
            width = 120
        }
    }
end

configs['folke/twilight.nvim'] = function()
    require('twilight').setup()
end

return configs
