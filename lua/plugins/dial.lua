local M = {
  packer = {
    keys = { '<C-a>', '<C-x>' },
  },
}

M.packer.config = function()
  local augend = require('dial.augend')
  require('dial.config').augends:register_group {
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.integer.alias.octal,
      augend.integer.alias.binary,
      augend.date.alias['%Y/%m/%d'],
      augend.date.alias['%Y-%m-%d'],
      augend.date.alias['%m/%d'],
      augend.date.alias['%H:%M'],
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
      augend.constant.alias.bool,
      augend.constant.alias.de_weekday_full,
      -- uppercase hex number (0x1A1A, 0xEEFE, etc.)
      augend.constant.new {
        elements = { 'and', 'or' },
        word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
        cyclic = true, -- "or" is incremented into "and".
      },
      augend.constant.new {
        elements = { '&&', '||' },
        word = false,
        cyclic = true,
      },
    },
    -- typescript = {
    --   augend.integer.alias.decimal,
    --   augend.integer.alias.hex,
    --   augend.constant.new { elements = { 'let', 'const' } },
    -- },
  }
  -- dial.nvim
  vim.keymap.set('n', '<C-a>', require('dial.map').inc_normal(), { noremap = true })
  vim.keymap.set('n', '<C-x>', require('dial.map').dec_normal(), { noremap = true })
  vim.keymap.set('v', '<C-a>', require('dial.map').inc_visual(), { noremap = true })
  vim.keymap.set('v', '<C-x>', require('dial.map').dec_visual(), { noremap = true })
  vim.keymap.set('v', 'g<C-a>', require('dial.map').inc_gvisual(), { noremap = true })
  vim.keymap.set('v', 'g<C-x>', require('dial.map').dec_gvisual(), { noremap = true })
end

return M
