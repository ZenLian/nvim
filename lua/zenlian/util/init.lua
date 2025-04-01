local LazyUtil = require("lazy.core.util")

local M = {}

local PREFIX = ...
return setmetatable(M, {
  __index = function(_, key)
    if LazyUtil[key] then
      return LazyUtil[key]
    end
    local module = require(PREFIX .. '.' .. key)
    rawset(M, key, module)
    return module
  end,
})
