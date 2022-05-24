require('dressing').setup({
  input = {
    enable = true,
    default_prompt = '﯀',
    border = 'single',
    winblend = 3,
    winhighlight = 'FloatBorder:Blue',
  },
  select = {
    enable = true,
    backend = { 'telescope' },
    get_config = function(opts)
      if opts.kind == 'codeaction' then
        return {
          telescope = require('telescope.themes').get_cursor(),
        }
      end
    end,
  },
})
