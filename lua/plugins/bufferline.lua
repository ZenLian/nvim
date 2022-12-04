local config = function()
  require('bufferline').setup {
    options = {
      -- separator_style = 'slant',
      offsets = {
        {
          filetype = 'neo-tree',
          text = '  Neo Tree',
          highlight = 'NeoTreeNormal',
          text_align = 'left',
        },
        {
          filetype = 'drex',
          text = '  Drex',
          highlight = 'NeoTreeNormal',
          text_align = 'left',
        },
      },
    },
    -- custom_filter = function(buf_number, buf_numbers)
    -- end
    highlights = require('catppuccin.groups.integrations.bufferline').get(),
    -- themable = true,
  }
end

return {
  config = config,
}
