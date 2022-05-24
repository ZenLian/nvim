local M = {}

function M.dump(...)
    print(vim.inspect(...))
end

function M.join_path(...)
    return table.concat({ ... }, '/')
end

-- some global paths
M.paths = {}
M.paths.config = vim.fn.stdpath('config')
M.paths.home = os.getenv("HOME")
M.paths.cache = M.join_path(M.paths.home, '.cache', 'nvim')
M.paths.plugins = M.join_path(M.paths.config, 'lua', 'plugins')
M.paths.data = M.join_path(vim.fn.stdpath('data'), 'site')

-- reload config
function M.reload()
    vim.cmd('source ' .. os.getenv("MYVIMRC"))
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

M.functions = {}

function M.execute(id)
    local func = M.functions[id]
    if not func then
        M.error("Function not exist: " .. id, "util")
    end
    return func()
end

-- TODO: use vim.keymap.set
function M.map(mode, lhs, rhs, opts)
    local defaults = {
        nowait = true,
        noremap = true,
        silent = true,
    }
    opts = vim.tbl_deep_extend("force", defaults, opts or {})
    if type(rhs) == "function" then
        table.insert(M.functions, rhs)
        if opts.expr then
            rhs = ([[luaeval('require("core.util").execute(%d)')]]):format(#M.functions)
        else
            rhs = ([[<cmd>lua require("core.util").execute(%d)<cr>]]):format(#M.functions)
        end
    end

    if opts.buffer ~= nil then
        local buffer = opts.buffer
        opts.buffer = nil
        return vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
    else
        return vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
end

function M.float_terminal(cmd)
    local buf = vim.api.nvim_create_buf(false, true)
    local vpad = 4
    local hpad = 10
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = vim.o.columns - hpad * 2,
        height = vim.o.lines - vpad * 2,
        row = vpad,
        col = hpad,
        style = "minimal",
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    })
    vim.fn.termopen(cmd)
    local autocmd = {
        "autocmd! TermClose <buffer> lua",
        string.format("vim.api.nvim_win_close(%d, {force = true});", win),
        string.format("vim.api.nvim_buf_delete(%d, {force = true});", buf),
    }
    vim.cmd(table.concat(autocmd, " "))
    vim.cmd([[startinsert]])
end

function M.toggle(option, silent)
    local info = vim.api.nvim_get_option_info(option)
    local scopes = { buf = "bo", win = "wo", global = "o" }
    local scope = scopes[info.scope]
    local options = vim[scope]
    options[option] = not options[option]
    if silent ~= true then
        if options[option] then
            M.info("enabled vim." .. scope .. "." .. option, "Toggle")
        else
            M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
        end
    end
end

_G.dump = M.dump


return M
