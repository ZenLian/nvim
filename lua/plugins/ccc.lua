local config = function()
  local ccc = require('ccc')
  ccc.setup {
    highlighter = {
      auto_enable = true,
    },
  }
end

return {
  packer = {
    event = { 'BufRead', 'BufNewFile' },
    config = config,
  },
}
