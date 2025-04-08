local M = {}

local function resolve(spec)
  local keymap = {}
  keymap.lhs = spec[1]
  spec[1] = nil
  keymap.rhs = spec[2]
  spec[2] = nil
  keymap.mode = spec.mode or 'n'
  spec.mode = nil
  keymap.opts = vim.deepcopy(spec)
  return keymap
end

-- @usage
-- keymap.set({"lhs", "rhs", mode = "n", desc = "description"})
-- keymap.set({
--  {}, -- multiple keymaps
-- }, { buffer = bufnr })
M.set = function(spec, opts)
  if spec == nil or #spec == 0 then
    return
  end
  spec = vim.deepcopy(spec)

  local keymaps = {}

  if type(spec[1]) == 'table' then
    for _, one_spec in ipairs(spec) do
      keymaps[#keymaps + 1] = resolve(one_spec)
    end
  else
    keymaps[#keymaps + 1] = resolve(spec)
  end

  for _, key in pairs(keymaps) do
    local key_opts = vim.tbl_extend('force', key.opts, opts or {})
    key_opts.silent = key_opts.silent ~= false
    vim.keymap.set(key.mode, key.lhs, key.rhs, key_opts)
  end
end

return M
