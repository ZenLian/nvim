local module_prefix = 'modules.'
local modules_list = {'ui', 'tools', 'editor','completion'}
local repos = {}

for _, module in ipairs(modules_list) do
    local plugins = require(module_prefix..module..'.plugins')
    for name, options in pairs(plugins) do
        repos[#repos + 1] = vim.tbl_extend('force', {name}, options)
    end
end

return repos
