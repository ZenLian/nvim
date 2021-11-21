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
|[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)|状态栏|
|[akinsho/nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua)|buffer tab 管理|
|[kyazdani42/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)|文件浏览器|
|[lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)|显示缩进对齐辅助线|
|[zen-mode.nvim](https://github.com/folke/zen-mode.nvim)|专注模式|
|[twilight.nvim](https://github.com/folke/twilight.nvim)|专注当前代码块，配合 zen-mode 使用|

### tools

### editor

## Keymappings

`<Leader>` 为空格键

### 基本按键

|key|action|
|-|-|
|`H`/`L`|移动到行首/尾|
|`<Leader>w`|保存|
|`<Leader>q`|关闭|
|`<Leader><Enter>`|关闭搜索结果高亮|
|`<A-j>`/`<Alt-k>`|交换上下行|
|`[t`/`]t`|切换tab页|

### packer

|key|action|
|-|-|
|`<Leader>ps`|`:PackerSync`|

### bufferline

|key|action|
|-|-|
|`[b`/`]b`|切换 buffer|
|`<Leader>bb`|选择 buffer|
|`<Leader>bc`|选择 buffer　关闭|
|`<Leader>b[`|关闭左侧 buffer|
|`<Leader>b]`|关闭右侧 buffer|

### nvim-tree

|key|action|
|-|-|
|`<C-n>`|toggle nvim-tree|
|`<Leader>nf`|find files|
|`<Leader>nr`|refresh|

- [ ] keymaps in nvim-tree

### zenmode && twilight

|key|action|
|-|-|
|`<Leader>zz`|toggle zenmode|
|`<Leader>zt`|toggle twilight|

### telescope

|key|action|
|-|-|
|C-k/C-j|上下移动|

## 不为人知的 vim 原生操作

### 大小写转换

- `~` 键可以转换当前字母的大小写，并移动到下一个字母。
- Visual 模式下：`g~`/`gu`/`gU` 分别可以切换大小写/切换为小写/切换为大写
- `g~`/`gu`/`gU` 后还可以跟 textobject，如 `gUaw` 把当前单词切换为大写

## TODO

- [ ] telescope ui 改成一列的