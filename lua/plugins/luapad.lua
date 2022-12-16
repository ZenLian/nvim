local M = {
  packer = {
    module = 'luapad',
  },
}

function M.packer.config()
  local luapad = require('luapad')
  luapad.setup {
    on_init = function()
      vim.bo.buflisted = false
    end,
  }
end

M.packer.keymaps = {
  n = {
    ['<leader>L'] = { '<cmd>lua require("luapad").init()<cr>', 'Luapad' },
  },
}

return M
