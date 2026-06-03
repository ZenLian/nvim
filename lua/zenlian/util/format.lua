local util = require('zenlian.util')
local M = {}

function M.enabled(bufnr)
  if bufnr == nil or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  local gaf = vim.g.zl_autoformat
  local baf = vim.b[bufnr].zl_autoformat
  if baf ~= nil then
    return baf
  end
  return gaf ~= false
end

function M.enable(state, buf)
  if state == nil then
    state = true
  end
  if buf then
    vim.b.zl_autoformat = state
  else
    vim.g.zl_autoformat = state
    vim.b.zl_autoformat = nil
  end
end

function M.toggle(buf)
  M.enable(not M.enabled(buf), buf)
end

function M.format(opts)
  opts = opts or {}
  require('conform').format(opts)
end

-- @param buf?:boolean
function M.snacks_toggle(buf)
  return Snacks.toggle {
    name = 'Format On Save (' .. (buf and 'Buffer' or 'Global') .. ')',
    get = function()
      if not buf then
        return vim.g.zl_autoformat == nil or vim.g.zl_autoformat
      else
        return M.enabled()
      end
    end,
    set = function(state)
      M.enable(state, buf)
    end,
  }
end

function M.setup()
  util.on_vim_enter(function()
    M.snacks_toggle(true):map('<leader>\\F')
    M.snacks_toggle():map('<leader>\\f')
  end)
end

return M
