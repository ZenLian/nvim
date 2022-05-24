local prefix = 'plugins.'
local modules_list = { 'ui', 'tools', 'editor', 'completion', 'langs' }
local repos = {}

for _, module in ipairs(modules_list) do
  local plugins = require(prefix .. module)
  for name, options in pairs(plugins) do
    repos[#repos + 1] = vim.tbl_extend('force', { name }, options)
  end
end

return repos
