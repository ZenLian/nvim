local ui = {}

ui['sainnhe/edge'] = {}
ui['kyazdani42/nvim-web-devicons'] = {}
ui['nvim-lualine/lualine.nvim'] = {
    requires = 'kyazdani42/nvim-web-devicons'
}
ui['akinsho/nvim-bufferline.lua'] = {
    opt = true,
    event = "BufRead",
    requires = 'kyazdani42/nvim-web-devicons'
}
ui['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    cmd = {"NvimTreeToggle", "NvimTreeOpen"}
}
ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    event = 'BufRead'
}
ui['norcalli/nvim-colorizer.lua'] = {
    config = function()
        require('colorizer').setup()
    end
}

ui['folke/zen-mode.nvim'] = {
    opt = true,
    cmd = {"ZenMode"}
}
ui['folke/twilight.nvim'] = {
    opt = true,
    cmd = {"Twilight"}
}

return ui
