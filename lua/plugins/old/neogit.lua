local M = {
  packer = {
    cmd = 'Neogit',
  },
}

M.packer.config = function()
  require('neogit').setup {
    disable_commit_confirmation = true,
    -- kind = 'floating',
    signs = {
      -- section = { '', '' },
      -- item = { '', '' },
      -- hunk = { '', '' },
      --  
      --  
      --  
      --  
      --  
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
    integrations = {
      diffview = true,
    },
  }
end

M.packer.keymaps = {
  n = {
    ['<leader>gg'] = { '<cmd>Neogit<CR>', 'Neogit' },
  },
}

return M
