local M = {
  packer = {
    module = 'luapad',
  },
}

function M.packer.config()
  local luapad = require('luapad')
  luapad.setup {}
end

M.packer.keymaps = {
  n = {
    ['<leader>L'] = { '<cmd>lua require("luapad").init()<cr>', 'Luapad' },
  },
}

return M
