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

tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", opt=true, module="sqlite"}},
    config = function()
        require('telescope').load_extension('frecency')
    end
}

tools["nvim-telescope/telescope-smart-history.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", opt=true, module="sqlite"}},
    config = function()
        require('telescope').load_extension('smart_history')
    end
}

tools['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    cmd = {"NvimTreeToggle", "NvimTreeOpen"}
}

tools["AckslD/nvim-neoclip.lua"] = {
    requires = {{"tami5/sqlite.lua", opt=true, module="sqlite"}}
}

tools["ahmedkhalf/project.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    config = function()
        require('project_nvim').setup()
        require('telescope').load_extension('projects')
    end
}

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    event = "BufRead"
}

tools["rmagatti/auto-session"] = { }
tools["rmagatti/session-lens"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
}

tools["folke/which-key.nvim"] = {
   opt = true,
   event = "BufRead"
}

tools["dstein64/vim-startuptime"] = {
    opt = false
}

return tools
