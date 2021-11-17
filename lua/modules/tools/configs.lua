configs = {}

--configs['nvim-telescope/telescope.nvim'] = function()
--    require('telescope').setup()
--end

configs['folke/which-key.nvim'] = function()
    require('which-key').setup()
end

return configs
