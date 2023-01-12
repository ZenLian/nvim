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

return M
