local fn = vim.fn
local globals = require('core.globals')
local packer_compile_path = fn.stdpath('data') .. '/packer_compiled.lua'
local packer_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(packer_dir)) > 0 then
    packer_bootstrap = fn.system {'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir}
end

-- load packer
packer = require('packer')
packer.startup({
    function(use)
        use {'wbthomason/packer.nvim'}
        use 'lewis6991/impatient.nvim'
        local repos = require('modules')
        for _, repo in ipairs(repos) do
            use(repo)
        end
        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({
                    border = "none",
                })
            end
        }
    }
})

