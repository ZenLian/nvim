local M = {}

function M.dump(...)
  print(vim.inspect(...))
end
_G.dump = M.dump

function M.join_path(...)
  return table.concat({ ... }, '/')
end

function M.tbl_merge(defaults, opts)
  return vim.tbl_deep_extend('force', defaults or {}, opts or {})
end

function M.foreach(list, callback)
  for k, v in pairs(list) do
    callback(v, k)
  end
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

-- usage:
-- augroup {
--   group1 = autocmd,
--   group2 = {
--     autocmd1,
--     autocmd2,
--   },
--   ...
-- }
M.augroup = function(groups) -- {name=autocmds}
  for name, autocmds in pairs(groups) do
    local group = vim.api.nvim_create_augroup(name, { clear = true })
    local create_autocmd = vim.api.nvim_create_autocmd
    -- {autocmd, autocmd, ...}
    if autocmds.event == nil then
      M.foreach(autocmds, function(autocmd)
        local event = autocmd.event
        autocmd.event = nil
        autocmd.group = group
        create_autocmd(event, autocmd)
      end)
    else -- autocmd without wrapper {}
      local event = autocmds.event
      autocmds.event = nil
      autocmds.group = group
      create_autocmd(event, autocmds)
    end
  end
end

function M.keymap(mode, lhs, rhs, opts)
  opts = M.tbl_merge({ noremap = true, silent = true }, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

local function do_keymaps(keys, opts)
  -- first is rhs, a final keymap
  if keys[1] then
    local rhs = keys[1]
    keys[1] = nil
    if keys[2] then
      keys.desc = keys[2]
      keys[2] = nil
    end
    keys = vim.tbl_deep_extend('force', keys, opts.opts or {})
    M.keymap(opts.modes, opts.lhs, rhs, keys)
    return
  end
  for key, value in pairs(keys) do
    do_keymaps(value, { lhs = opts.lhs .. key, modes = opts.modes, opts = opts.opts })
  end
end

-- keymaps:
-- {
--   n = {
--     ['<leader>z'] = {
--       a = { '<cmd>whatever<cr>', 'desc', nowait = true}
--       b = { function() do_some_thing end, desc = 'desc', nowait = true}
--     }
--   },
--   -- for multi mode
--   ['nv'] = { ... }
--   -- for `:map'
--   [''] = { ... },
-- }
function M.keymaps(keymaps, opts)
  local options = { nowait = true, silent = true }
  options = vim.tbl_deep_extend('force', options, opts or {})
  for mode, keys in pairs(keymaps) do
    local modes = {}
    if mode == '' then
      modes = { '' }
    else
      for i = 1, #mode do
        table.insert(modes, mode:sub(i, i))
      end
    end
    do_keymaps(keys, { lhs = '', modes = modes, opts = options })
  end
end

-->https://kgithub.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua
-- delay notifications till vim.notify was replaced or after 500ms
function M.lazy_notify()
  local notifs = {}
  local function temp(...)
    table.insert(notifs, vim.F.pack_len(...))
  end

  local orig = vim.notify
  vim.notify = temp

  local timer = vim.loop.new_timer()
  local check = vim.loop.new_check()

  local replay = function()
    timer:stop()
    check:stop()
    if vim.notify == temp then
      vim.notify = orig -- put back the original notify if needed
    end
    vim.schedule(function()
      ---@diagnostic disable-next-line: no-unknown
      for _, notif in ipairs(notifs) do
        vim.notify(vim.F.unpack_len(notif))
      end
    end)
  end

  -- wait till vim.notify has been replaced
  check:start(function()
    if vim.notify ~= temp then
      replay()
    end
  end)
  -- or if it took more than 500ms, then something went wrong
  timer:start(500, 0, replay)
end

return M
