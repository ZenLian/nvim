local M = {}
local config = require('config')
local util = require('core.util')
local lsputil = vim.lsp.util

local FORMATTING = 'textDocument/formatting'
local TITLE = 'Formatting'

local function priority(name)
  return config.format_priority[name] or 0
end

local function select_client(on_choice)
  local clients = vim.tbl_values(vim.lsp.buf_get_clients())
  clients = vim.tbl_filter(function(client)
    return client.supports_method(FORMATTING)
  end, clients)

  -- only reserve clients with max priority
  local max_priority = 0
  for _, client in ipairs(clients) do
    max_priority = math.max(priority(client.name), max_priority)
  end
  clients = vim.tbl_filter(function(client)
    return priority(client.name) == max_priority
  end, clients)

  if #clients > 1 then
    vim.ui.select(clients, {
      prompt = 'Select a language server:',
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

-- TODO: use vim.lsp.format with `filter` in v0.8
function M.format(bufnr, timeout_ms)
  if not config.format_on_save then
    return
  end

  local params = lsputil.make_formatting_params {}
  -- local bufnr = vim.api.nvim_get_current_buf()

  select_client(function(client)
    local result, err = client.request_sync(FORMATTING, params, timeout_ms, bufnr)
    if result and result.result then
      lsputil.apply_text_edits(result.result, bufnr, client.offset_encoding)
      -- util.info('autoformat by ' .. client.name, NAME)
    elseif err then
      util.warn(err, TITLE)
    end
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

local group = vim.api.nvim_create_augroup('LspFormat', { clear = true })
function M.on_attach(client, bufnr)
  if not client.supports_method(FORMATTING) then
    return
  end

  -- dont create autocmds twice
  -- multiple servers are handled in A same callback
  local autocmds = vim.api.nvim_get_autocmds { group = group, buffer = bufnr }
  if autocmds == nil then
    return
  end

  -- vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
  vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = group,
    buffer = bufnr,
    callback = function()
      M.format(bufnr, 2000)
    end,
  })
end

return M
