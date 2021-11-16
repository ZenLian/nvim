local fn = vim.fn
local globals = require('core.globals')

local packer_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if not vim.loop.fs_stat(packer_dir) then
  packer_bootstrap = fn.system {'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir}
end

packer = require('packer')
vim.cmd('packadd packer.nvim')
packer.startup(function(use)
    use {'sainnhe/edge'}

    if packer_bootstrap then
        packer.sync()
    end
end)
    

