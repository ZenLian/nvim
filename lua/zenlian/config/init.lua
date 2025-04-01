local M = {}

local options = {
    colorscheme = "catppuccin"
}

M._setup = false
M.setup = function()
    M._setup = true

    require("zenlian.config.options")
    require("zenlian.config.keymaps")

    -- require("catppuccin").load()
    vim.cmd.colorscheme(options.colorscheme)
end

return setmetatable(M, {
    __index = function(_, key)
        if not M._setup then
            M.setup()
        end
        return options[key]
    end
})