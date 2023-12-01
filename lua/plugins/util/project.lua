local spec = {
  'ahmedkhalf/project.nvim',
  -- event = 'VeryLazy',
  lazy = false,
  config = function()
    require('project_nvim').setup {
      silent_chdir = false,
    }
  end,
}

return { spec }
