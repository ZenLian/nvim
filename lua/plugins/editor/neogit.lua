local spec = {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  keys = {
    { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' },
  },
  opts = function()
    local has_icon = require('config').icons.enabled
    local opts = {
      disable_commit_confirmation = true,
      -- kind = 'floating',
      integrations = {
        diffview = true,
      },
    }
    if has_icon then
      opts.signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      }
    end
    return opts
  end,
}

return { spec }
