---@type LazyPluginSpec[]
return {
  {
    'danymat/neogen',
    keys = {
      {
        '<leader>lg',
        function()
          require('neogen').generate()
        end,
        desc = 'Generate Annotations (Neogen)',
      },
    },
    opts = {
      snippet_engine = 'nvim',
    },
  },
}
