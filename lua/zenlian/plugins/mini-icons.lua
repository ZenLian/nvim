---@type LazyPluginSpec[]
return {
  {
    'echasnovski/mini.icons',
    enabled = false,
    version = false,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
}
