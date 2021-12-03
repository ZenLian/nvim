local util = require "lspconfig.util"
local configs = require "lspconfig.configs"
local servers = require "nvim-lsp-installer.servers"
local server = require "nvim-lsp-installer.server"
local path = require "nvim-lsp-installer.path"
local shell = require "nvim-lsp-installer.installers.shell"

local server_name = "pyls"
local root_files = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git'
}

-- 1. (optional, only if lspconfig doesn't already support the server)
--    Create server entry in lspconfig
configs[server_name] = {
    default_config = {
        filetypes = { "python" },
        root_dir = util.root_pattern(unpack(root_files)),
        single_file_support = true,
        settings = {
            pyls = {
                enable = true,
                configurationSources = {
                    "pycodestyle"
                },
            }
        },
    },
    docs = {
        description = [[
https://pypi.org/project/python-language-server

A Python 2.7 and 3.5+ implementation of the Language Server Protocol.
        ]],
    },
}

local root_dir = server.get_server_root_path(server_name)

-- You may also use one of the prebuilt installers (e.g., std, npm, pip3, go, gem, shell).
local my_installer = function(server, callback, context)
    -- local is_success = shell.bash [[conda install python-language-server -y]]
    local is_success = shell.bash [[pip2 install python-language-server]]
    if is_success then
        callback(true)
    else
        callback(false)
    end
end

-- 2. (mandatory) Create an nvim-lsp-installer Server instance
local my_server = server.Server:new {
    name = server_name,
    root_dir = root_dir,
    homepage = "https://pypi.org/project/python-language-server",
    installer = my_installer,
    default_options = {
        filetypes = { "python" },
        cmd = { "python", "-mpyls", "-vv", "--log-file", "/tmp/pyls.log" },
    },
}

-- 3. (optional, recommended) Register your server with nvim-lsp-installer.
--    This makes it available via other APIs (e.g., :LspInstall, lsp_installer.get_available_servers()).
servers.register(my_server)
