local spec = {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  -- use noice instead
  cond = false,
}

spec.config = function()
  require('dressing').setup {
    input = {
      enable = true,
      default_prompt = '﯀',
      border = 'single',
      win_options = {
        winblend = 3,
        -- winhighlight = 'FloatBorder:Blue',
      },
      get_config = function(opts)
        if opts.kind == 'center' then
          return {
            relative = 'editor',
          }
        end
      end,
    },
    select = {
      enable = true,
      backend = { 'telescope' },
      get_config = function(opts)
        if opts.kind == 'codeaction' then
          return {
            telescope = require('telescope.themes').get_cursor(),
          }
        end
      end,
    },
  }
end

return { spec }
