local spec = {
  'rafcamlet/nvim-luapad',
  keys = {
    { '<leader>L', '<cmd>lua require("luapad").init()<cr>', desc = 'Luapad' },
  },
  opts = {
    on_init = function()
      vim.bo.buflisted = false
    end,
  },
}

return spec
