local config = function()
  require('which-key').setup {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
  }
end

return {
  config = config,
}
