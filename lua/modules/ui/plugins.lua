local ui = {}
local configs = require("modules.ui.configs")

--#region colorschemes
-- ui['zenlian/edgeme'] = {
ui['~/source/edgeme'] = {
    config = configs.edgeme,
}
ui['sainnhe/edge'] = {
    config = function()
        vim.g.edge_enable_italic = false
        vim.g.edge_show_eob = false
        vim.g.edge_diagnostic_virtual_text = true
    end
}
-- ui['ThemerCorp/themer.lua'] = {
--     config = configs.themer
-- }
--#endregion colorschemes

-- required by many plugins
-- ui['kyazdani42/nvim-web-devicons'] = {}

ui['windwp/windline.nvim'] = {
    config = configs.windline,
}

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
    cmd = { "ZenMode" },
    config = configs.zen_mode,
}
ui['folke/twilight.nvim'] = {
    opt = true,
    cmd = { "Twilight" },
    config = function()
        require('twilight').setup()
    end
}

ui['goolord/alpha-nvim'] = {
    event = "BufWinEnter",
    config = configs.alpha
}

ui['rcarriga/nvim-notify'] = {
    config = function()
        require('modules.ui.notify')
    end
}

-- provide prettier ui hook for vim.ui.input and vim.ui.select
ui['stevearc/dressing.nvim'] = {
    config = function ()
        require('modules.ui.dressing')
    end
}

return ui
