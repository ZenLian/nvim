local spec = {
  'echasnovski/mini.indentscope',
  -- event = 'BufWinEnter',
  event = 'BufReadPre',
  opts = function()
    local O = require('config')
    local opts = {
      symbol = '│',
      draw = {
        delay = 100,
      },
    }
    if O.animation == false then
      opts.draw.animation = require('mini.indentscope').gen_animation.none()
    end
    return opts
  end,
  config = function(_, opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'alpha',
        'dashboard',
        'neo-tree',
        'Trouble',
        'lazy',
        'mason',
        'aerial',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
    require('mini.indentscope').setup(opts)
  end,
}

return { spec }
