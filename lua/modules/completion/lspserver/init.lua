local M = {}
local custom_servers = {"pyls"}

M.setup = function()
    for _, server in ipairs(custom_servers) do
        require("modules.completion.lspserver."..server)
    end
end

return M
