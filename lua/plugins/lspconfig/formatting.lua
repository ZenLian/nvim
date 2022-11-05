local M = {}
local config = require('config').config
local util = require('util')

local TITLE = 'Formatting'
local FORMATTING_METHOD = 'textDocument/formatting'
local TIMEOUT = 2000

function M.priority(name)
  return config.format_priority[name] or 0
end

function M.select_client(on_choice)
  local clients = vim.tbl_values(vim.lsp.get_active_clients())
  clients = vim.tbl_filter(function(client)
    return client.supports_method(FORMATTING_METHOD)
  end, clients)

  -- filter clients with max priority
  local max_priority = 0
  for _, client in ipairs(clients) do
    max_priority = math.max(M.priority(client.name), max_priority)
  end
  clients = vim.tbl_filter(function(client)
    return M.priority(client.name) == max_priority
  end, clients)

  -- prompt for selection
  if #clients > 1 then
    vim.ui.select(clients, {
      prompt = TITLE .. 'select a language server',
      format_item = function(client)
        return client.name
      end,
    }, on_choice)
  elseif #clients < 1 then
    on_choice(nil)
  else
    on_choice(clients[1])
  end
end

function M.format(opts)
  local defaults = {
    bufnr = 0,
    timeout_ms = TIMEOUT,
  }
  opts = vim.tbl_extend('force', defaults, opts or {})
  M.select_client(function(client)
    opts.id = client.id
    vim.lsp.buf.format(opts)
  end)
end

function M.toggle()
  config.format_on_save = not config.format_on_save
  if config.format_on_save then
    util.info('Enable autoformat', TITLE)
  else
    util.warn('Disabled autoformat', TITLE)
  end
end

local group = vim.api.nvim_create_augroup(TITLE, { clear = true })
function M.on_attach(client, bufnr)
  if not client.supports_method(FORMATTING_METHOD) then
    return
  end

  -- dont create autocmds twice
  -- multiple servers are handled in the same callback
  local autocmds = vim.api.nvim_get_autocmds { group = group, buffer = bufnr }
  if #autocmds > 0 then
    return
  end

  -- vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = group,
    buffer = bufnr,
    callback = function()
      if not config.format_on_save then
        return
      end
      M.format { bufnr = bufnr }
    end,
  })
end

return M
