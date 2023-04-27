local spec = {
  'echasnovski/mini.starter',
  lazy = false,
  -- event = 'VeryLazy',
}

local header = {
  '                                 ',
  '███╗   ██╗██╗   ██╗██╗███╗   ███╗',
  '████╗  ██║██║   ██║██║████╗ ████║',
  '██╔██╗ ██║██║   ██║██║██╔████╔██║',
  '██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
  '██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
  '╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
  '                                 ',
}

spec.config = function(_, opts)
  local starter = require('mini.starter')

  local actions = {
    { name = 'Edit new buffer', action = 'enew', section = 'Actions' },
    { name = 'Quit Neovim', action = 'qall', section = 'Actions' },
    function()
      return {
        -- { action = 'Telescope file_browser', name = 'Browser', section = 'Actions' },
        { action = 'Telescope command_history', name = 'Command history', section = 'Actions' },
        { action = 'Telescope find_files', name = 'Files', section = 'Actions' },
        { action = 'Telescope help_tags', name = 'Help tags', section = 'Actions' },
        { action = 'Telescope live_grep', name = 'Live grep', section = 'Actions' },
        { action = 'Telescope oldfiles', name = 'Old files', section = 'Actions' },
      }
    end,
  }

  starter.setup {
    header = table.concat(header, '\n'),
    footer = table.concat(require('util').fortune(80), '\n'),
    items = {
      -- starter.sections.builtin_actions(),
      -- starter.sections.telescope(),
      actions,
      starter.sections.recent_files(5, true, false),
      starter.sections.recent_files(5, false),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing('all', { 'Actions' }),
      starter.gen_hook.padding(5, 2),
      starter.gen_hook.aligning('left', 'center'),
    },
  }
end

return { spec }
