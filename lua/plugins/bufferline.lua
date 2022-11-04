local config = function()
  require('bufferline').setup {
    options = {
      -- separator_style = 'slant',
      offsets = {
        {
          filetype = 'NvimTree',
          text = '  File Explorer',
          highlight = 'BufferLineTabClose',
          text_align = 'left',
        },
      },
    },
    -- themable = true,
  }
end

return {
  config = config,
}
