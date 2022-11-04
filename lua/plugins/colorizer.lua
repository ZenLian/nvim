local config = function()
  require('colorizer').setup {
    filetypes = {
      '*',
      css = {
        names = true,
        rgb_fb = true, -- rgb(...)
      },
    },
    user_default_options = {
      names = false,
    },
  }
end

return {
  config = config,
}
