-- packer wrapper
local M = {}

local util = require('util')
local cfg = require('config').config

function M.bootstrap()
  local fn = vim.fn
  local packer_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(packer_dir)) > 0 then
    local prefix = 'https://github.com/'
    if cfg.packer.use_ssh then
      prefix = 'git@github.com:'
    end
    fn.system { 'git', 'clone', '--depth=1', prefix .. 'wbthomason/packer.nvim', packer_dir }
    return true
  end
end

function M.is_loaded(plugin)
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
  if t == 'function' then
    return plugin
  elseif t == 'string' then
    name = plugin.config
  else
    name = plugin.as or get_name(plugin)
  end
  local ok, pkg = pcall(require, 'plugins.' .. name)
  if ok and pkg.config then
    plugin.config = pkg.config
  end

  return plugin
end

function M.setup(opts)
  local bootstrap = M.bootstrap()

  local packer = require('packer')
  packer.startup {
    function(use)
      use { 'wbthomason/packer.nvim' }
      for _, plugin in ipairs(opts.plugins) do
        plugin = preprocess(plugin)
        use(plugin)
      end
    end,
    config = opts.config,
  }

  if bootstrap then
    packer.sync()
  end
end

return M
