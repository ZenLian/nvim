local spec = {
  'toppair/peek.nvim',
  build = { 'deno task --quiet build:fast' },
  init = function()
    local util = require('util')
    util.augroup {
      ['plugins.peek'] = {
        event = 'FileType',
        pattern = 'markdown',
        callback = function()
          util.keymaps({
            ['<Leader>lP'] = {
              function()
                local peek = require('peek')
                if peek.is_open() then
                  peek.close()
                else
                  peek.open()
                end
              end,
              desc = 'Live preview',
            },
          }, { buffer = true })
        end,
      },
    }
  end,
  config = true,
}

return { spec }
