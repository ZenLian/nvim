local config = function()
  require('nvim-tree').setup {
    update_focused_file = {
      enable = true,
      -- update_cwd = true
    },
    filters = {
      custom = { '^\\.git$' },
    },
    view = {
      width = 30,
      mappings = {
        list = {
          { key = 'l', action = 'edit' },
          { key = 'h', action = 'close_node' },
        },
      },
    },
  }
end

return {
  config = config,
}
