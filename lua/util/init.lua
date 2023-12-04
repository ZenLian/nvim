local M = {}

local PREFIX = ...
return setmetatable(M, {
  __index = function(_, key)
    local module = require(PREFIX .. '.' .. key)
    rawset(M, key, module)
    return module
  end,
})
