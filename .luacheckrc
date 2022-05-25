---@diagnostic disable: lowercase-global

-- Rerun tests only if their modification time changed.
cache = true

read_globals = {
  'vim',
}

globals = {
  'vim.g',
}
