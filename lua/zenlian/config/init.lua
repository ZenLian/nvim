local M = {}

M._setup = false
M.setup = function()
    M._setup = true

    require("zenlian.config.options")
    require("zenlian.config.keymaps")
end

return setmetatable(M, {
    __index = function(_, key)
        if not M._setup then
            M.setup()
        end
    end
})