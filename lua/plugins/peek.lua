local config = function()
  local peek = require('peek')
  -- require('peek').setup {}
  vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
  vim.api.nvim_create_user_command('PeekClose', peek.close, {})
  vim.api.nvim_create_user_command('PeekToggle', function()
    if peek.is_open() then
      peek.close()
    else
      peek.open()
    end
  end, {})
end

return { config = config }
