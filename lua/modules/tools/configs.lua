local home = require('core.globals').home_dir

local configs = {}

configs['nvim-telescope/telescope.nvim'] = function()
    if not packer_plugins["nvim-neoclip.lua"].loaded then
        vim.cmd [[packadd nvim-neoclip.lua]]
    end
    require('telescope').load_extension('neoclip')
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
    if not packer_plugins["sqlite.lua"].loaded then
        vim.cmd [[packadd sqlite.lua]]
    end
    require('neoclip').setup{
        enable_persistant_history = true,
    }
end

configs['folke/which-key.nvim'] = function()
    require('which-key').setup()
end

return configs
