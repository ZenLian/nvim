if vim.fn.winnr('$') > 2 then
  vim.cmd([[wincmd J]])
else
  vim.cmd([[wincmd L]])
end
