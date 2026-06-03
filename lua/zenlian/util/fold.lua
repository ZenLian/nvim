local M = {}

function M.foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local line_text = vim.fn.substitute(line, "\t", " ", "g")
  return string.format("%s ...(%d lines)", line_text, line_count)
end

return M
