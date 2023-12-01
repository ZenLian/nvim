-- use vim.ui.input to input tag name
local function input_tag()
  vim.ui.input({
    prompt = 'Tag this file:',
    kind = 'center',
  }, function(input)
    if input and input ~= '' then
      require('grapple').tag { key = input }
    end
  end)
end

local spec = {
  'cbochs/grapple.nvim',
  keys = {
    { '<Leader>mm', '<cmd>lua require("grapple").popup_tags()<cr>', desc = 'Popup tags' },
    { '<Leader>m/', '<cmd>lua require("grapple").toggle()<cr>', desc = 'Toggle tag' },
    { '<Leader>mn', input_tag, desc = 'Named tag' },
    { '<Leader>m[', '<cmd>lua require("grapple").cycle_backward()<cr>', desc = 'Previous tagged file' },
    { '<Leader>m]', '<cmd>lua require("grapple").cycle_forward()<cr>', desc = 'Next tagged file' },
  },
}

return { spec }
