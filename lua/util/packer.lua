-- packer wrapper
local M = {}

local util = require('util')
local cfg = require('config').config

local packer_config = {
  display = {
    open_fn = function()
      return require('packer.util').float {
        border = 'single',
      }
    end,
  },
  -- log = { level = 'info' },
  -- profile = {
  --   enable = true,
  --   threshold = 0,
  -- },
}

local url_map = {
  default = 'https://github.com/%s',
  ssh = 'git@github.com:%s',
  gitclone = 'https://gitclone.com/github.com/%s',
  kgithub = 'https://kgithub.com/%s',
}
packer_config.git = {
  default_url_format = url_map[cfg.packer.git_src] or url_map.default,
}

function M.bootstrap()
  local fn = vim.fn
  local packer_dir = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
  if fn.empty(fn.glob(packer_dir)) > 0 then
    local url = string.format(packer_config.git.default_url_format, 'wbthomason/packer.nvim')
    print(string.format('cloning %s into %s', url, packer_dir))
    fn.system { 'git', 'clone', '--depth=1', url, packer_dir }
    return true
  end
end

function M.loaded(plugin)
  return packer_plugins[plugin] and packer_plugins[plugin].loaded
end

local function get_name(plugin)
  local parts = vim.split(plugin[1], '/')
  local name = parts[#parts]:lower()
  name = name:gsub('%.n?vim$', '')
  name = name:gsub('^n?vim%-', '')
  name = name:gsub('%-n?vim$', '')
  name = name:gsub('%.lua$', '')
  name = name:gsub('%.', '_')
  return name
end

local preprocess = function(plugin)
  -- local plugin
  if plugin.is_local then
    plugin[1] = util.join_path(cfg.packer.local_dir, plugin[1])
    plugin.is_local = nil
  end

  -- seperated config
  local t = type(plugin.config)
  local name
  if t == 'string' then
    name = plugin.config
  elseif plugin.config == true then
    name = plugin.as or get_name(plugin)
  else
    return plugin
  end
  local pkg = require('plugins.' .. name)
  plugin.config = pkg.config

  return plugin
end

function M.setup(opts)
  local bootstrap = M.bootstrap()

  vim.cmd([[packadd packer.nvim]])
  local packer = require('packer')
  packer.startup {
    function(use)
      use { 'wbthomason/packer.nvim', opt = true }
      for _, plugin in ipairs(opts.plugins) do
        plugin = preprocess(plugin)
        use(plugin)
      end
    end,
    config = packer_config,
  }

  if bootstrap then
    packer.sync()
  end
end

return M
