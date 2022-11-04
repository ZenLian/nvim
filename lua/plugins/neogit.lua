local config = function()
  require('neogit').setup {
    disable_commit_confirmation = true,
    -- kind = "floating",
    signs = {
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
    integrations = {
      diffview = true,
    },
  }
end

return {
  config = config,
}
