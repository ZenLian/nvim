local config = {}

-- default options
config.options = {
    style = 'aura',
    enable_italic = 'false',
}

-- update options
config.update = function(options)
    config.options = vim.tbl_deep_extend("force", config.options, options)
end

return config
