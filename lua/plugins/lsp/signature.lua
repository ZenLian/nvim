-- TODO: WIP
local util = require('util')

-- module definition
local M = {
  enabled = true,
}

-- helper definition
local H = {
  augroup = vim.api.nvim_create_augroup('lsp.signature', { clear = true }),
  timer = vim.loop.new_timer(),
  -- track lsp requests status
  status = nil,
  request_id = 0, -- increasing id
  cancel_func = nil, -- request func to be sent
  winnr = nil, -- signature window
}

M.on_attach = function(client, bufnr)
  if not client.supports_method('textDocument/signatureHelp') then
    return
  end
  -- require('lsp_signature').on_attach({
  --   bind = true,
  --   handler_opts = {
  --     border = 'single',
  --   },
  --   hint_prefix = '😽 ',
  --   hint_scheme = 'LspSignatureActiveParameter',
  -- }, bufnr)

  vim.api.nvim_clear_autocmds { group = H.augroup, buffer = bufnr }
  vim.api.nvim_create_autocmd('CursorMovedI', {
    group = H.augroup,
    buffer = bufnr,
    callback = H.auto_signature,
    -- callback = vim.lsp.buf.signature_help,
  })
end

-- handler for "textDocument/signatureHelp"
-- copied from: vim.lsp.handlers.signature_help
H.signature_help_handler = function(_, result, ctx, config)
  config = config or {}
  config.focus_id = ctx.method
  if not (result and result.signatures and result.signatures[1]) then
    if config.silent ~= true then
      vim.notify('No signature help available')
    end
    return
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  local triggers = vim.tbl_get(client.server_capabilities, 'signatureHelpProvider', 'triggerCharacters')
  local ft = vim.api.nvim_buf_get_option(ctx.bufnr, 'filetype')
  local lines, hl = vim.lsp.util.convert_signature_help_to_markdown_lines(result, ft, triggers)
  lines = vim.lsp.util.trim_empty_lines(lines)
  if vim.tbl_isempty(lines) then
    if config.silent ~= true then
      vim.notify('No signature help available')
    end
    return
  end

  local bufnr, winnr = vim.lsp.util.open_floating_preview(lines, 'markdown', config)
  if hl then
    vim.api.nvim_buf_add_highlight(bufnr, -1, 'LspSignatureActiveParameter', 0, unpack(hl))
  end
  return bufnr, winnr
end

-- send request
H.signature_request = function()
  local request_id = H.request_id + 1
  H.request_id = request_id

  local params = vim.lsp.util.make_position_params()
  _, H.cancel_func = vim.lsp.buf_request(
    0,
    'textDocument/signatureHelp',
    params,
    vim.lsp.with(H.signature_help_handler, { silent = true, request_id = request_id })
  )
end

H.auto_signature = function()
  if not M.enabled then
    return
  end

  H.timer:stop()
  if not util.lsp.has_capability('signatureHelpProvider') then
    return
  end

  local left_char = H.get_left_char()
  if not H.is_trigger(left_char) then
    return
  end

  H.timer:start(200, 0, vim.schedule_wrap(H.signature_request))
end

H.get_left_char = function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return string.sub(line, col, col)
end

H.is_trigger = function(char)
  local clients = vim.lsp.get_active_clients { bufnr = 0 }
  for _, client in ipairs(clients) do
    local triggers = vim.tbl_get(client, 'server_capabilities', 'signatureHelpProvider', 'triggerCharacters')
    if vim.tbl_contains(triggers or {}, char) then
      return true
    end
  end
  return false
end

return M
