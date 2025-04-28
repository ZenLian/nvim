---@type LazyPluginSpec[]
return {
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>ls', '<cmd>AerialToggle<cr>', desc = 'Symbols (Aerial)' },
      { '<leader>;', '<cmd>AerialToggle<cr>', desc = 'Symbols (Aerial)' },
    },
    opts = function()
      local icons = vim.deepcopy(require('zenlian.config').icons.kinds)
      icons.lua = { Package = icons.Control }
      return {
        attach_mode = 'global',
        show_guides = true,
        icons = icons,
        filter_kind = {
          ['_'] = {
            'Class',
            'Constructor',
            'Enum',
            'Field',
            'Function',
            'Interface',
            'Method',
            'Module',
            'Namespace',
            'Package',
            'Property',
            'Struct',
            'Trait',
          },
          markdown = false,
          help = false,
          lua = {
            'Class',
            'Constructor',
            'Enum',
            'Field',
            'Function',
            'Interface',
            'Method',
            'Module',
            'Namespace',
            -- 'Package', -- remove Package
            'Property',
            'Struct',
            'Trait',
          },
        },
      }
    end,
  },
}
