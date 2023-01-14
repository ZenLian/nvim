local spec = {
  'echasnovski/mini.animate',
  event = 'VeryLazy',
  -- cond = function()
  --   return require('config').animation ~= false
  -- end,
  config = function()
    local animate = require('mini.animate')
    animate.setup {
      cursor = {
        enable = false,
      },
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear { easing = 'in', duration = 100, unit = 'total' },
      },
      resize = {
        enable = true,
        timing = animate.gen_timing.linear { easing = 'in', duration = 100, unit = 'total' },
      },
      -- TODO: not work
      open = {
        enable = true,
        timing = animate.gen_timing.linear { easing = 'in', duration = 100, unit = 'total' },
      },
      close = {
        enable = true,
        timing = animate.gen_timing.linear { easing = 'in', duration = 100, unit = 'total' },
      },
    }
  end,
}

return { spec }
