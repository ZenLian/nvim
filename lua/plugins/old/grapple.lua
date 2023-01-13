local M = {
  packer = {
    module = 'grapple',
    config = function()
      require('grapple').setup {}
    end,
  },
}

-- use vim.ui.input to input tag name
function M.input_tag()
  vim.ui.input({
    prompt = 'Tag this file:',
    kind = 'center',
  }, function(input)
    if input and input ~= '' then
      require('grapple').tag { key = input }
    end
  end)
end

M.keymaps = {
  ['<Leader>m'] = {
    m = { '<cmd>lua require("grapple").popup_tags()<cr>', 'Popup tags' },
    ['/'] = { '<cmd>lua require("grapple").toggle()<cr>', 'Toggle tag' },
    n = { '<cmd>lua require("plugins.grapple").input_tag()<cr>', 'Named tag' },
    ['['] = { '<cmd>lua require("grapple").cycle_backward()<cr>', 'Previous tagged file' },
    [']'] = { '<cmd>lua require("grapple").cycle_forward()<cr>', 'Next tagged file' },
  },
}

return M
