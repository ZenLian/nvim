local spec = {
  'kevinhwang91/nvim-bqf',
  ft = 'qf',
  opts = {
    preview = {
      border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
    },
    filter = {
      fzf = {
        extra_opts = { '--bind', 'ctrl-o:toggle-all', '--delimiter', '│' },
      },
    },
  },
}

return { spec }
