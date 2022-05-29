# neovim lua 配置

> **此文档更新滞后于功能！**

纯 lua neovim 配置

- 使用 packer.nvim 管理插件
- 使用 lspconfig 实现语言 LSP 配置
- 使用 treesitter 辅助分析代码

## 前置要求

- neovim >= 0.7.0
- fzf
- rg
- fd
- sqlite3(required by `sqlite.lua`)

```bash
sudo apt-get install sqlite3 libsqlite3-dev
```

## 插件

### ui

| 插件                                                                            | 描述                               |
| ------------------------------------------------------------------------------- | ---------------------------------- |
| [edge](https://github.com/sainnhe/edge)                                         | colorscheme                        |
| [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)            | 图标显示                           |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                    | 状态栏                             |
| [nvim-bufferline.lua](https://github.com/akinsho/bufferline.nvim)               | buffer tab 管理                    |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | 显示缩进对齐辅助线                 |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)            | 颜色显示                           |
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)                         | 专注模式                           |
| [twilight.nvim](https://github.com/folke/twilight.nvim)                         | 专注当前代码块，配合 zen-mode 使用 |

### tools

telescope 及其扩展：

| 插件                                                                                     | 描述                |
| ---------------------------------------------------------------------------------------- | ------------------- |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                       | 模糊搜索神器        |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | 加速 telescope 搜索 |
| [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)     | MRU 文件搜索        |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                           | 剪切板列表          |
| [project.nvim](https://github.com/ahmedkhalf/project.nvim)                               | project ALL IN ONE  |

其它：

| 插件                                                                | 描述             |
| ------------------------------------------------------------------- | ---------------- |
| [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)        | 文件浏览器       |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)       | neovim 中的终端  |
| [which-key.nvim](https://github.com/folke/which-key.nvim)           | 快捷键管理与提示 |
| [vim-startuptime.nvim](https://github.com/dstein64/vim-startuptime) | vim 启动时间查看 |

### editor

treesitter 及其扩展：

| 插件                                                                                         | 描述                          |
| -------------------------------------------------------------------------------------------- | ----------------------------- |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                        | treesitter                    |
| [nvim-treesitter-textobject](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | 基于 treesitter 的 textobject |
| [nvim-treesitter-context](https://github.com/lewis6991/nvim-treesitter-context)              | 将当前函数固定在顶部          |
| [nvim-treehopper](https://github.com/mfussenegger/nvim-treehopper)                           | 代码块快速选择                |
| [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)                                   | 多层括号颜色区分              |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim)                                     | 快速注释                      |

其他：

| 插件                                                     | 描述                     |
| -------------------------------------------------------- | ------------------------ |
| [lightspeed](https://github.com/ggandor/lightspeed.nvim) | 光标快速定位             |
| [surround](https://github.com/ur4ltz/surround.nvim)      | nvim 版本的 vim-surround |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim)   | git 插件                 |

### completion

补全和 LSP 相关插件

==TODO==

## Keymappings

`<Leader>` 为空格键

### 基本按键

| key               | action           |
| ----------------- | ---------------- |
| `H`/`L`           | 移动到行首/尾    |
| `<Leader>w`       | 保存             |
| `<Leader>q`       | 关闭             |
| `<Leader><Enter>` | 关闭搜索结果高亮 |
| `<A-j>`/`<A-k>`   | 交换上下行       |
| `[t`/`]t`         | 切换 tab 页      |

### packer

| key          | action          |
| ------------ | --------------- |
| `<Leadek>/s` | `:PackerSync`   |
| `<Leadek>/t` | `:PackerStatus` |

### bufferline

| key          | action           |
| ------------ | ---------------- |
| `[b`/`]b`    | 切换 buffer      |
| `<Leader>bb` | 选择 buffer 打开 |
| `<Leader>bc` | 选择 buffer 关闭 |
| `<Leader>b[` | 关闭左侧 buffer  |
| `<Leader>b]` | 关闭右侧 buffer  |

### nvim-tree

| key          | action           |
| ------------ | ---------------- |
| `<C-n>`      | toggle nvim-tree |
| `<Leader>nn` | focus nvim-tree  |
| `<Leader>nf` | find files       |
| `<Leader>nr` | refresh          |

keymaps in nvim-tree:

| key            | action                                 |
| -------------- | -------------------------------------- |
| `g?`           | help                                   |
| **navigation** |                                        |
| `<c-]`         | cd                                     |
| `<BS>`         | close node                             |
| `P`            | parent node                            |
| `<`/`>`        | last/next sibling                      |
| `K`/`J`        | first/last sibling                     |
| **view**       |                                        |
| `H`            | toggle hidden                          |
| `I`            | toggle git ignored                     |
| `R`            | refresh                                |
| **open file**  |                                        |
| `o`/`<CR>`     | edit                                   |
| `<C-v>`        | vsplit                                 |
| `<C-x>`        | split                                  |
| `<C-t>`        | edit in tab                            |
| `s`            | system open                            |
| **operation**  |                                        |
| `a`            | create file(`a dir/` create directory) |
| `r`            | rename                                 |
| `d`            | delete                                 |
| `D`            | trash delete                           |
| `x`            | cut                                    |
| `c`            | copy                                   |
| `p`            | paste                                  |
| `y`            | copy name                              |
| `Y`            | copy path                              |

### zenmode && twilight

| key          | action          |
| ------------ | --------------- |
| `<Leader>zz` | toggle zenmode  |
| `<Leader>zt` | toggle twilight |

### telescope

打开不同的 list：

| key          | action         |
| ------------ | -------------- |
| `<C-p>`      | git 文件       |
| `<Leader>ff` | files          |
| `<Leader>fn` | 文件浏览器     |
| `<Leader>fg` | grep           |
| `<Leader>fb` | buffers        |
| `<Leader>ft` | help_tags      |
| `<Leader>fe` | 历史文件       |
| `<Leader>fh` | frecency       |
| `<Leader>fp` | projects       |
| `<Leader>fc` | neoclip 剪贴板 |

| key             | action   |
| --------------- | -------- |
| `<C-k>`/`<C-j>` | 上下移动 |

### toggleterm

| key          | action           |
| ------------ | ---------------- |
| `<C-\>`      | toggle terminal  |
| `<Leader>gg` | open lazygit tui |

### treesitter 及其扩展

| textobjects              |                                                |
| ------------------------ | ---------------------------------------------- |
| **select(text objects)** |                                                |
| `f`                      | function                                       |
| `c`                      | class                                          |
| `a`                      | parameter                                      |
| `b`                      | block                                          |
| **move**                 |                                                |
| `]]`/`[[`                | move to next/prev function                     |
| `]c`/`[c`                | move to next/prev class                        |
| `]a`/`[a`                | move to next/prev parameter                    |
| **swap**                 |                                                |
| `<Leader>]a`             | swap with next parameter                       |
| `<Leader>[a`             | swap with previous parameter                   |
| **lsp_interop**          |                                                |
| `<Leader>df`             | peek function definition(Press twice to enter) |
| `<Leader>dF`             | peek class definition(Press twice to enter)    |

| treehopper        |      |
| ----------------- | ---- |
| **visual 模式下** |      |
| `m`               | 选区 |

### Comment

- `gc`/`gb` 分别是行注释/块注释
- 并且支持 `.` 重复命令
- 也可以 `gc{motion}` 注释一个代码块，比如 `gcip` 注释一个段落等。

### lightspeed

如果你以前是 vim-sneak 用户，那么 lightspeed 绝对是你的首选。（更喜欢 easymotion 的话，你应该选择 hop.nvim。）

按下 `s`/`S`，后面跟 1~2 个字符，就可以在屏幕任意字母中跳转了。

同时高亮了 `f`/`t` 的目标，默认继续按 `f`/`t` 到下一个字母。我习惯于用 `;`/`,`，所以我还是映射到 `;`/`,` 上了。

### surround

visual 模式下选中后按 `s` 在两边插入括号。

### gitsigns

| key              | action            |
| ---------------- | ----------------- |
| `]g`/`[g`        | next/prev hunk    |
| `<Leader>gs`     | stage hunk        |
| `<Leader>gS`     | stage buffer      |
| `<Leader>gu`     | undo stage hunk   |
| `<Leader>gU`     | undo stage buffer |
| `<Leader>gr`     | reset hunk        |
| `<Leader>gR`     | reset buffer      |
| `<Leader>gp`     | preview hunk      |
| `<Leader>gb`     | show blame        |
| **text objects** |                   |
| `ag`/`ig`        | a hunk            |

## 一些 vim 原生操作技巧

### 大小写转换

- `~` 键可以转换当前字母的大小写，并移动到下一个字母。
- Visual 模式下：`g~`/`gu`/`gU` 分别可以切换大小写/切换为小写/切换为大写
- `g~`/`gu`/`gU` 后还可以跟 textobject，如 `gUaw` 把当前单词切换为大写

### 拼写检查

- `:set spell` 开启拼写检查
- `[s`/`]s`: 上一个/下一个拼写错误
- `z=`: 显示拼写建议
- `zg`: 单词添加到 `spellfile` 词典
- `zG`: 单词添加到内置词典

## ❤️ Credits

- [ayamir/nvimdots](https://github.com/ayamir/nvimdots)
- [folke/dot](https://github.com/folke/dot/tree/master/config/nvim)
