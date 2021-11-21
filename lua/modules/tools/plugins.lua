local tools = {}

tools["nvim-lua/plenary.nvim"] = {}
tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    cmd = "Telescope",
    requires = {{"nvim-lua/plenary.nvim", opt = false}}
}

tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    run = "make",
    after = "telescope.nvim",
    config = function()
        require('telescope').load_extension('fzf')
    end
}

tools["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    config = function()
        require('telescope').load_extension('project')
    end
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", opt = true}},
    config = function()
        if not packer_plugins["sqlite.lua"].loaded then
            vim.cmd [[packadd sqlite.lua]]
        end
        require('telescope').load_extension('frecency')
    end
}

tools["AckslD/nvim-neoclip.lua"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", module='sqlite'}},
}

--tools["folke/which-key.nvim"] = {
--    opt = true,
--    keys = " ",
--}

tools["dstein64/vim-startuptime"] = {
    opt = false
}

return tools
