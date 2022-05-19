vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd [[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
require("tsht").config.hint_keys = { "j", "k", "l", "f", "d", "s", "h", "g", "m" }
