local ui = {}

--#region colorschemes
-- ui['zenlian/edgeme'] = {
ui['~/source/edgeme'] = {
    config = function()
        vim.o.background = 'dark'
        require('edgeme').setup {
            style = 'aura',
        }
        vim.cmd [[colorscheme edgeme]]
    end
}
-- ui['ThemerCorp/themer.lua'] = {
--     config = configs.themer
-- }
--#endregion colorschemes

ui['windwp/windline.nvim'] = {
    config = function()
        require('plugins.ui.windline')
    end
}

ui['akinsho/bufferline.nvim'] = {
    opt = true,
    event = "BufRead",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require('plugins.ui.bufferline')
    end
}

ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    event = 'BufRead',
    config = function()
        require('plugins.ui.indent_blankline')
    end
}

ui['norcalli/nvim-colorizer.lua'] = {
    config = function()
        require('plugins.ui.colorizer')
    end
}

ui['folke/zen-mode.nvim'] = {
    opt = true,
    cmd = { "ZenMode" },
    config = function()
        require('plugins.ui.zen_mode')
    end
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
    config = function()
        require('plugins.ui.alpha')
    end
}

ui['rcarriga/nvim-notify'] = {
    event = "VimEnter",
    config = function()
        require('plugins.ui.notify')
    end
}

-- provide prettier ui hook for vim.ui.input and vim.ui.select
ui['stevearc/dressing.nvim'] = {
    config = function()
        require('plugins.ui.dressing')
    end
}

return ui