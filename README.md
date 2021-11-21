# neovim lua 配置

深度参考（~~Ctrl+C, Ctrl+V~~）[ayamir/nvimdots](https://github.com/ayamir/nvimdots) 的纯 lua neovim 配置。

## 前置要求

- neovim > 0.5.1
- fzf
- rg
- fd

neovim 0.5.0 开始使用原生支持 lua 配置，并且内置 lsp 和 treesitter
等特性，比 coc.nvim 要快，不需要大量的 node 依赖。准备将原来的 coc 配置一点点迁移过来了。

- 使用 packer.nvim 替代 vim-plug
- 使用 lspconfig 替代 coc.nvim

## 插件

### ui

|插件|描述|
|---|---|
|[sainnhe/edge](https://github.com/sainnhe/edge)|colorscheme|
|[kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)|图标显示|
|[akinsho/nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua)|buffer tab页管理和显示|
|[kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)|文件浏览器|
|[lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)|显示缩进对齐辅助线|
|[folke/zen-mode.nvim](https://github.com/folke/zen-mode.nvim)|专注模式|

### tools

### editor

## Keymappings

### 基本按键

|||
|-|-|
|H/L|移动到行首/尾|

### telescope

|||
|-|-|
|C-k/C-j|上下移动|

## 不为人知的 vim 原生操作

### 大小写转换

- `~` 键可以转换当前字母的大小写，并移动到下一个字母。
- Visual 模式下：`g~`/`gu`/`gU` 分别可以切换大小写/切换为小写/切换为大写
- `g~`/`gu`/`gU` 后还可以跟 textobject，如 `gUaw` 把当前单词切换为大写
