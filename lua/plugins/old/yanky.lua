local config = function()
  require('yanky').setup {
    ring = {
      storage = 'sqlite',
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        mappings = nil, -- nil to use default mappings
      },
    },
    system_clipboard = {
      sync_with_ring = false,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 300,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  }
end

-- yanky.nvim
local function register_yanky()
  keymap({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
  keymap({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
  keymap({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
  keymap({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
  keymap({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
  keymap('n', '<A-]>', '<Plug>(YankyCycleForward)')
  keymap('n', '<A-[>', '<Plug>(YankyCycleBackward)')
  keymap('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)')
  keymap('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)')
  keymap('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)')
  keymap('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)')
  keymap('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)')
  keymap('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)')
  keymap('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)')
  keymap('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)')
  keymap('n', '=p', '<Plug>(YankyPutAfterFilter)')
  keymap('n', '=P', '<Plug>(YankyPutBeforeFilter)')
end

return {
  packer = {
    requires = { 'kkharji/sqlite.lua' },
    config = config,
  },
}
