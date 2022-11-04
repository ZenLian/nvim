local config = function()
  require('todo-comments').setup {
    highlight = {
      before = '',
      keyword = 'bg',
      after = '',
    },
  }
end

return {
  config = config,
}
