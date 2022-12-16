local M = {
  packer = {
    ft = { 'markdown' },
    -- cmd = { 'PeekOpen', 'PeekClose', 'PeekToggle' },
    run = { 'deno task --quiet build:fast' },
  },
}

M.packer.config = function()
  local peek = require('peek')
  peek.setup()
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

return M
