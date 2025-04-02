local M = {}

-- get plugin
M.plugin = function(name)
    return require("lazy.core.config").spec.plugins[name]
end

M.has = function(name)
    return M.plugin(name) ~= nil
end

M.is_loaded = function(name)
    local Config = require("lazy.core.config")
    return Config.plugins[name] and Config.plugins[name]._.loaded
end

M.opts = function(plugin_name)
    local plugin = M.plugin(plugin_name)
    if not plugin then
        return {}
    end
    return require('lazy.core.plugin').values(plugin, "opts", false)
end

return M