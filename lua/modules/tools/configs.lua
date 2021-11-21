local home = require('core.globals').home_dir

local configs = {}

configs['nvim-telescope/telescope.nvim'] = function()
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next"
                }
            },
        },
        extensions = {
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = {"*.git/*", "*/tmp/*"},
            },
        }
    }
end

configs["AckslD/nvim-neoclip.lua"] = function()
    require('neoclip').setup{
        enable_persistant_history = true,
    }
    require('telescope').load_extension('neoclip')
end

configs['folke/which-key.nvim'] = function()
    require('which-key').setup()
end

return configs
