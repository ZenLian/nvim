return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      preset = 'obsidian',
      heading = {
        sign = false,
        icons = {}
      },
      code = {
        sign = false,
        width = "block"
      }
    },
    ft = { "markdown" },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      Snacks.toggle({
        name = "Render Markdown",
        get = require('render-markdown').get,
        set = require('render-markdown').set,
      }):map("<leader>\\m")
    end
  }
}
