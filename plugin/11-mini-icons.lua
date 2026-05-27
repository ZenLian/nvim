vim.pack.add({ 'https://github.com/echasnovski/mini.icons' })

require('mini.icons').setup()

-- Mock nvim-web-devicons for plugins that depend on it.
package.preload["nvim-web-devicons"] = function()
  require("mini.icons").mock_nvim_web_devicons()
  return package.loaded["nvim-web-devicons"]
end
