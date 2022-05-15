local ui = {}
local configs = require("modules.ui.configs")

ui['sainnhe/edge'] = {
    -- config = configs.edge,
}

-- ui['Mofiqul/vscode.nvim'] = {
--     config = configs.vscode,
-- }

ui['windwp/windline.nvim'] = {
    config = configs.windline,
}

ui['kyazdani42/nvim-web-devicons'] = {}
ui['akinsho/bufferline.nvim'] = {
    opt = true,
    event = "BufRead",
    requires = 'kyazdani42/nvim-web-devicons',
    config = configs.bufferline,
}
ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    event = 'BufRead',
    config = configs.indent_blankline,
}
ui['norcalli/nvim-colorizer.lua'] = {
    config = function()
        require('colorizer').setup()
    end
}

ui['folke/zen-mode.nvim'] = {
    opt = true,
    cmd = {"ZenMode"},
    config = configs.zen_mode,
}
ui['folke/twilight.nvim'] = {
    opt = true,
    cmd = {"Twilight"},
    config = function()
        require('twilight').setup()
    end
}

return ui
