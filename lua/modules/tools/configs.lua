configs = {}

configs['nvim-telescope/telescope.nvim'] = function()
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-j>"] = "move_selection_next"
                }
            }
        }
    }
end

configs['nvim-telescope/telescope-fzf-native.nvim'] = function()
    require('telescope').load_extension('fzf')
end

configs['nvim-telescope/telescope-frecency.nvim'] = function()
    require('telescope').load_extension('frecency')
end

configs['folke/which-key.nvim'] = function()
    require('which-key').setup()
end

return configs
