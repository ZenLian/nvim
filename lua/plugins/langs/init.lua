local langs = {}

-- Markdown Preview
langs['ellisonleao/glow.nvim'] = {
  ft = { 'markdown' },
  cmd = 'Glow',
  config = function()
    vim.g.glow_binary_path = vim.env.HOME .. '/.local/bin'
  end,
}

langs['toppair/peek.nvim'] = {
  ft = { 'markdown' },
  -- cmd = { 'PeekOpen', 'PeekClose', 'PeekToggle' },
  run = { 'deno task --quiet build:fast' },
  config = function()
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
  end,
}

return langs
