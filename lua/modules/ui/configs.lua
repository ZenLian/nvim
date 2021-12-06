local configs = {}

configs.edge = function()
    vim.o.background = 'dark'
    vim.g.edge_style = 'aura'
    --vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_better_performance = 1
    vim.cmd [[colorscheme edge]]
end

-- configs.lualine = function()
--     require('lualine').setup {
--         options = {
--             icons_enabled = true,
--             component_separators = '',
--             section_separators = '',
--             disabled_filetypes = {'toggleterm'}
--         },
--         sections = {
--             lualine_a = {
--                 { 'mode', fmt = function(str) return str:sub(1,1) end }
--             },
--         },
--         extentions = {
--             'nvim-tree',
--             'toggleterm'
--         }
--     }
-- end
--

configs.windline = function ()
    -- 0 #2b2d37
    -- 1 #ec7279
    -- 2 #a0c980
    -- 3 #deb974
    -- 4 #6cb6eb
    -- 5 #d38aea
    -- 6 #5dbbc1
    -- 7 #c5cdd9
    require('modules.ui.windline.evil_line')
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
