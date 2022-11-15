local M = {}

function M.dump(...)
  print(vim.inspect(...))
end

function M.join_path(...)
  return table.concat({ ... }, '/')
end

function M.tbl_merge(defaults, opts)
  return vim.tbl_deep_extend('force', defaults or {}, opts or {})
end

-- reload config
function M.reload()
  vim.cmd('source ' .. os.getenv('MYVIMRC'))
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

-- Open float terminal with command
--- @param cmd: #String The name of shell command
function M.float_terminal(cmd)
  local buf = vim.api.nvim_create_buf(false, true)
  local vpad = 4
  local hpad = 10
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = 'minimal',
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  })
  vim.fn.termopen(cmd)
  local autocmd = {
    'autocmd! TermClose <buffer> lua',
    string.format('vim.api.nvim_win_close(%d, {force = true});', win),
    string.format('vim.api.nvim_buf_delete(%d, {force = true});', buf),
  }
  vim.cmd(table.concat(autocmd, ' '))
  vim.cmd([[startinsert]])
end

-- Toggle vim options
-- Parameters: ~
--     {name}  Option name
--     {opts}  Optional parameters
--             • scope: one of 'buf', 'win', 'global'
--             • silent: true to disable notification.
--
-- Return: ~
--     nil
-- @param name string
-- @param opts? table<string, any>
function M.toggle(name, opts)
  local defaults = {
    scope = nil,
    value = nil,
    silent = false,
  }
  opts = M.tbl_merge(defaults, opts)

  -- scope
  local scopes = { buf = 'bo', win = 'wo', global = 'o' }
  local scope = scopes[opts.scope]
  if not scope then
    local info = vim.api.nvim_get_option_info(name)
    scope = scopes[info.scope]
  end

  -- value
  local options = vim[scope]
  if type(opts.value) == 'boolean' then
    options[name] = opts.value
  else
    options[name] = not options[name]
  end

  -- silent
  if opts.silent ~= true then
    local value = options[name]
    local msg = string.format('vim.%s.%s = %s', scope, name, value)
    if value then
      M.info(msg, 'Toggle')
    else
      M.warn(msg, 'Toggle')
    end
  end
end

_G.dump = M.dump

return M
