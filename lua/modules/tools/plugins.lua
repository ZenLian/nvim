local tools = {}

tools['nvim-lua/plenary.nvim'] = {}

tools['nvim-telescope/telescope.nvim'] = {
    opt = true,
    cmd = "Telescope",
    requires = "nvim-lua/plenary.nvim"
}

--tools['folke/which-key.nvim'] = {
--    opt = true,
--    keys = " ",
--}

return tools
