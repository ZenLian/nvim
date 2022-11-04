local config = function()
  require('leap').setup {
    special_keys = {
      repeat_search = '<enter>',
      next_phase_one_target = '<enter>',
      next_target = { '<enter>', ';' },
      prev_target = { '<space>', ',' },
      next_group = '<tab>',
      prev_group = '<space>',
      multi_accept = '<enter>',
      multi_revert = '<backspace>',
    },
  }
  require('leap').add_default_mappings()
end

return { config = config }
