local globals = {}

function join_path(path_sep, ...)
    return table.concat({...}, path_sep)
end

function globals:init()
    self.os_name = vim.loop.os_uname().sysname
    self.is_mac = self.os_name == 'Darwin'
    self.is_linux = self.os_name == 'Linux'
    self.is_windows = self.os_name == 'Windows'
    path_sep = self.is_windows and '\\' or '/'

    self.config_path = vim.fn.stdpath('config')
    self.home_dir = self.is_windows and os.getenv("USERPROFILE") or os.getenv("HOME")
    self.cache_dir = join_path(path_sep, self.home_dir, '.cache', 'nvim')
    print(self.cache_dir)
    self.modules_dir = join_path(path_sep, self.config_path, 'modules')
    self.data_dir = join_path(path_sep, vim.fn.stdpath('data'), 'site')
end

globals:init()

return globals
