local fn = vim.fn
local globals = require('core.globals')
local packer_compile_path = fn.stdpath('data') .. '/packer_compiled.lua'
local packer_dir = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(packer_dir)) > 0 then
    packer_bootstrap = fn.system {'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir}
end

-- load packer
vim.cmd('packadd packer.nvim')
packer = require('packer')
packer.init({
    compile_path = packer_compile_path,
    display = {
        open_fn = function()
            return require("packer.util").float({border = "single"})
        end
    }
})
packer.reset()

local use = packer.use
use {'wbthomason/packer.nvim', opt=true}
--use {'sainnhe/edge'}
local repos = require('modules')
for _, repo in ipairs(repos) do
    use(repo)
end

if packer_bootstrap then
    packer.sync()
end

