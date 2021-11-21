local globals = {}

function join_path(...)
    return table.concat({...}, '/')
end

function globals:init()
    self.config_path = vim.fn.stdpath('config')
    self.home_dir =  os.getenv("HOME")
    self.cache_dir = join_path(self.home_dir, '.cache', 'nvim')
    self.modules_dir = join_path(self.config_path, 'lua', 'modules')
    self.data_dir = join_path(vim.fn.stdpath('data'), 'site')
end

function globals:reload()
    vim.cmd('source ' .. self.config_path .. '/init.lua')
end

globals:init()

return globals
