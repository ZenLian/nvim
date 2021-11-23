# neovim lua 配置

深度参考（~~Ctrl+C, Ctrl+V~~）[ayamir/nvimdots](https://github.com/ayamir/nvimdots) 的纯 lua neovim 配置。

neovim 0.5.0 开始使用原生支持 lua 配置，并且内置 lsp 和 treesitter
等特性，比 coc.nvim 要快，不需要大量的 node 依赖。准备将原来的 coc 配置一点点迁移过来了。

- 使用 packer.nvim 替代 vim-plug
- 使用 lspconfig 替代 coc.nvim

## 前置要求

- neovim > 0.5.1
- fzf
- rg
- fd
- sqlite3(required by `sqlite.lua`)

```bash
sudo apt-get install sqlite3 libsqlite3-dev
```

## 插件

### ui

|插件|描述|
|---|---|
|[edge](https://github.com/sainnhe/edge)|colorscheme|
|[nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)|图标显示|
|[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)|状态栏|
|[nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua)|buffer tab 管理|
|[nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)|文件浏览器|
|[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)|显示缩进对齐辅助线|
|[nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)|显示缩进对齐辅助线|
|[zen-mode.nvim](https://github.com/folke/zen-mode.nvim)|专注模式|
|[twilight.nvim](https://github.com/folke/twilight.nvim)|专注当前代码块，配合 zen-mode 使用|

### tools

telescope 及其扩展：

|插件|描述|
|---|---|
|[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)|required by telescope|
|[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)|模糊搜索神器|
|[telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)|加速 telescope 搜索|
|[telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)|MRU 文件搜索|
|[nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)|剪切板列表|
|[project.nvim](https://github.com/ahmedkhalf/project.nvim)|project ALL IN ONE|

其它：

|插件|描述|
|[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)|terminal tools|
|---|---|
|[vim-startuptime.nvim](https://github.com/dstein64/vim-startuptime)|vim 启动时间查看|

### editor

|插件|描述|
|---|---|
|[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)|treesitter|
|[nvim-treesitter-textobject](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)|基于 treesitter 的 textobject|
|[nvim-treehopper](https://github.com/mfussenegger/nvim-treehopper)|基于 treesitter 的快速选择 textobjects|
|[lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim)|屏幕内移动光标最佳方案|

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

打开不同的 list：

|key|action|
|-|-|
|`<C-p>`|git 文件|
|`<Leader>ff`|files|
|`<Leader>fn`|文件浏览器|
|`<Leader>fg`|grep|
|`<Leader>fb`|buffers|
|`<Leader>ft`|help_tags|
|`<Leader>fe`|历史文件|
|`<Leader>fh`|frecency|
|`<Leader>fp`|project|
|`<Leader>fc`|neoclip 剪贴板|

|key|action|
|-|-|
|C-k/C-j|上下移动|

### toggleterm

|key|action|
|-|-|
|`<C-\>`|toggle terminal|

### treesitter 及其扩展

|textobjects||
|-|-|
|**select(text objects)**||
|`f`|function|
|`c`|class|
|`a`|parameter|
|`b`|block|
|**move**||
|`]]`/`[[`|move to next/prev function|
|`]c`/`[c`|move to next/prev class|
|`]a`/`[a`|move to next/prev parameter|
|**swap**||
|`<Leader>]a`|swap with next parameter|
|`<Leader>[a`|swap with previous parameter|
|**lsp_interop**||
|`<Leader>df`|peek function definition(Press twice to enter)|
|`<Leader>dF`|peek class definition(Press twice to enter)|

|treehopper||
|-|-|
|**visual 模式下**||
|`m`|选区|

### lightspeed

如果你以前是 vim-sneak 用户，那么 lightspeed 绝对是你的首选。（更喜欢 easymotion 的话，你应该选择 hop.nvim。）

按下 `s`/`S`，后面跟 1~2 个字符，就可以在屏幕任意字母中跳转了。

同时高亮了 `f`/`t` 的目标，默认继续按 `f`/`t` 到下一个字母。我习惯于用 `;`/`,`，所以我还是映射到 `;`/`,` 上了。

### gitsigns

|treehopper||
|-|-|
|`]h`/`[h`|next/prev hunk|
|`<Leader>hs`|stage hunk|
|`<Leader>hS`|stage buffer|
|`<Leader>hu`|undo stage hunk|
|`<Leader>hU`|undo stage buffer|
|`<Leader>hr`|reset hunk|
|`<Leader>hR`|reset buffer|
|`<Leader>hp`|preview hunk|
|`<Leader>hb`|show blame|
|**text objects**||
|`ah`/`ih`|a hunk|

## 不为人知的 vim 原生操作

### 大小写转换

- `~` 键可以转换当前字母的大小写，并移动到下一个字母。
- Visual 模式下：`g~`/`gu`/`gU` 分别可以切换大小写/切换为小写/切换为大写
- `g~`/`gu`/`gU` 后还可以跟 textobject，如 `gUaw` 把当前单词切换为大写

## TODO

- [ ] telescope ui 改成一列的
- [ ] telescope 文件浏览器改为 ranger 风格
- [ ] is0n/fm-nvim 和 telescope 文件浏览器比较
  - [ ] nvim-tree keymaps
- [x] toggleterm
- [ ] dap
- [ ] lsp
  - [ ] nlsp-settings.nvim
  - [ ] tab keymaps like vscode
- [ ] dashboard.nvim
- [ ] lazygit
