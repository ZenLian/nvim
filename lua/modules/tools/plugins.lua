local tools = {}
local configs = require("modules.tools.configs")

-- utilities required by others
tools["nvim-lua/plenary.nvim"] = { opt = true, module = "plenary" }
tools["tami5/sqlite.lua"] = { opt = true, module = "sqlite" }

--#region Telescope

tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    cmd = "Telescope",
    module = "telescope",
    requires = { { "nvim-lua/plenary.nvim", opt = false } },
    config = configs.telescope,
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
    requires = { { "tami5/sqlite.lua" } },
    config = function()
        require('telescope').load_extension('frecency')
    end
}

tools["nvim-telescope/telescope-smart-history.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = { { "tami5/sqlite.lua" } },
    config = function()
        require('telescope').load_extension('smart_history')
    end
}

tools["AckslD/nvim-neoclip.lua"] = {
    requires = {
        { "tami5/sqlite.lua" },
        { "nvim-telescope/telescope.nvim" },
    },
    config = configs.neoclip,
}

tools["ahmedkhalf/project.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    config = function()
        require('project_nvim').setup()
        require('telescope').load_extension('projects')
    end
}
--#endregion Telescope

tools['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeRefresh", "NvimTreeFocus" },
    config = configs.nvim_tree,
}

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    event = { "BufRead", "BufNewFile" },
    config = configs.toggleterm,
}

tools["folke/which-key.nvim"] = {
    config = configs.which_key,
}

tools["dstein64/vim-startuptime"] = {
    opt = false
}

return tools
