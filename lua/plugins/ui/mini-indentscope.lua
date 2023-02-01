local spec = {
  'echasnovski/mini.indentscope',
  event = { 'BufRead', 'BufNewFile' },
  opts = function()
    local opts = {
      symbol = '│',
      draw = {
        delay = 100,
      },
    }
    local O = require('config')
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
