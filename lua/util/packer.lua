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

local function preprocess(plugin)
  -- disabled plugin
  if plugin.disable then
    return nil
  end

  -- local plugin
  if plugin.local_pkg then
    local name = plugin.as or plugin[1]
    if type(plugin.local_pkg) == 'string' then
      name = plugin.local_pkg
    end
    plugin[1] = util.join_path(cfg.packer.local_dir, name)
    plugin.local_pkg = nil
  end

  -- plugin's keymaps
  if plugin.keymaps then
    util.keymaps(plugin.keymaps)
    plugin.keymaps = nil
  end

  -- call init functions
  if plugin.init then
    plugin.init()
    plugin.init = nil
  end

  return plugin
end

function M.setup(plugins)
  local bootstrap = M.bootstrap()

  vim.cmd([[packadd packer.nvim]])
  local packer = require('packer')
  packer.startup {
    function(use)
      use { 'wbthomason/packer.nvim', opt = true }
      for uid, plugin in pairs(plugins) do
        local t = type(plugin)
        if t == 'string' then
          -- seperated config
          local ok, pkg = pcall(require, 'plugins.' .. plugin)
          if not ok then
            util.error('missing config file for plugin ' .. uid, 'plugins')
          elseif not pkg.packer then
            util.error('missing field "packer" for plugin ' .. uid, 'plugins')
          else
            plugin = pkg.packer
          end
        elseif t ~= 'table' then
          util.error(string.format('cannot accept type "%s" for plugin "%s"', t, uid), 'plugins')
        end
        plugin[1] = uid
        plugin = preprocess(plugin)
        if plugin then
          use(plugin)
        end
      end
    end,
    config = packer_config,
  }

  if bootstrap then
    packer.sync()
  end
end

return M
