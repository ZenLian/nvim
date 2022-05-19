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
    requires = { { "nvim-lua/plenary.nvim" } },
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

tools["nvim-telescope/telescope-symbols.nvim"] = {
    after = "telescope.nvim",
}

tools["nvim-telescope/telescope-file-browser.nvim"] = {
    after = "telescope.nvim",
    config = function()
        require('telescope').load_extension('file_browser')
    end
}

tools["AckslD/nvim-neoclip.lua"] = {
    requires = {
        { "tami5/sqlite.lua" },
        { "nvim-telescope/telescope.nvim" },
    },
    config = configs.neoclip,
}

--#endregion Telescope

tools["Shatur/neovim-session-manager"] = {
    config = configs.session
}

tools['kyazdani42/nvim-tree.lua'] = {
    opt = true,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeRefresh", "NvimTreeFocus" },
    config = configs.nvim_tree,
}

tools["akinsho/toggleterm.nvim"] = {
    opt = true,
    module = "toggleterm",
    config = configs.toggleterm,
}

tools["folke/which-key.nvim"] = {
    config = function()
        require('modules.tools.whichkey')
    end
}

tools["dstein64/vim-startuptime"] = {
    opt = true,
    cmd = "StartupTime",
}

tools["lewis6991/impatient.nvim"] = {
    opt = false
}

tools["nathom/filetype.nvim"] = {
    opt = false,
    config = function()
        require("filetype").setup({
            overrides = {
                shebang = {
                    -- Set the filetype of files with a dash shebang to sh
                    dash = "sh",
                },
            },
        })
    end
}

return tools
