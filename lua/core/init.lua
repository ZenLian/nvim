
-- speedup
require('impatient').enable_profile()
local disabled_built_plugins = {
    "netrw",
    "gzip",
    "zip",
    "netrwPlugin",
    "netrwSettings",
    "tar",
    "tarPlugin",
    "netrwFileHandlers",
    "zipPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "spellfile_plugin",
    "matchit",
}
for _, plugin in ipairs(disabled_built_plugins) do
    vim.g["loaded_" .. plugin] = 1
end


vim.g.mapleader = " "
require('core.options')
require('core.autocmd')
-- require('core.keymaps')
require('core.pack')

