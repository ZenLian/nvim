local module_prefix = 'modules'
local modules_list = {'ui', 'tools', 'completion'}

local repos = {}

for _, module in ipairs(modules_list) do
    local plugins = require(module_prefix..'.'..module..'.plugins')
    local configs = require(module_prefix..'.'..module..'.configs')
    for name, options in pairs(plugins) do
        config = {}
        if configs[name] ~= nil then
            config = { config=configs[name] }
        end
        repos[#repos + 1] = vim.tbl_extend('force', {name}, options, config)
    end
end

return repos
