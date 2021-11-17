local tools = {}

tools["nvim-lua/plenary.nvim"] = {}

tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    cmd = "Telescope",
    requires = "nvim-lua/plenary.nvim"
}

tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = "make",
    after = "telescope.nvim"
}

tools["tami5/sqlite.lua"] = {}
tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", opt = true}}
}

--tools["folke/which-key.nvim"] = {
--    opt = true,
--    keys = " ",
--}

return tools
