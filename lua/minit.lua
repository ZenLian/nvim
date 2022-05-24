-- used for minimum vimrc debug

local fn = vim.fn
local packer_dir = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

local packer_bootstrap = nil
if fn.empty(fn.glob(packer_dir)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', packer_dir })
end

vim.cmd([[packadd packer.nvim]])
local packer = require('packer')
packer.startup({
  function(use)
    use({ 'wbthomason/packer.nvim', opt = true })

    -- use {'neovim/nvim-lspconfig'}
    -- use {'williamboman/nvim-lsp-installer'}

    -- use {'ray-x/lsp_signature.nvim'}

    -- use {'hrsh7th/nvim-cmp'}
    -- use {'hrsh7th/cmp-nvim-lsp'}

    -- use {'L3MON4D3/LuaSnip'}
    -- use {'saadparwaiz1/cmp_luasnip'}

    -- use {'windwp/nvim-autopairs'}
    -- use {'folke/which-key.nvim'}
    use('Mofiqul/vscode.nvim')
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end,
    },
  },
})

if packer_bootstrap then
  packer.sync()
end

-- Lua:
-- For dark theme
vim.g.vscode_style = 'dark'
-- For light theme
-- vim.g.vscode_style = "light"
-- Enable transparent background
-- vim.g.vscode_transparent = 1
-- Enable italic comment
vim.g.vscode_italic_comment = 1
-- Disable nvim-tree background color
-- vim.g.vscode_disable_nvimtree_bg = true
vim.cmd([[colorscheme vscode]])
