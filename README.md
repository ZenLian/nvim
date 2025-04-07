# 😽 Neovim lua config

Neovim configuration powered by [lazy.nvim](https://github.com/folke/lazy.nvim).

![screenshot](https://raw.githubusercontent.com/ZenLian/imglib/main/202211050611008.png)

## TODO

- [x] incremental_selection/textobjects 的快捷键
- [x] formatter
- [ ] linter

## 插件列表

### UI

- [x] [catppuccin](https://github.com/catppuccin/nvim): 主题
- [x] bufferline
- [ ] heirline 替换 bufferline

### coding

- [x] flash
- [x] mini.pairs
- [x] mini.ai
- [x] mini.surround
- [ ] ts-comments.nvim
- [ ] grug-far.nvim

### treesitter

- [x] rainbow-delimiters.nvim

### editor

- [x] which-key.nvim
- [ ] neotree 准备换成 yazi
- [x] fzf.lua

## 代码编辑

### text-objects(mini.ai)

- `o` 代码块（如 `if`、`for`）
- `f` **f**unction
- `a` **a**rgument
- `c` **c**lass
- `u` **u**sage 函数调用
- `d` 数字
- `t` tag
- `b` 括号 **b**rackets，即 `()[]{}`
- `q` 引号 **q**uotes，即 <code>""''``</code>
- `g` 全选
- `i` 缩进

### mini-surround

快捷键以 `gs` 开头：

- `gsa` 添加
- `gsr` 替换
- `gsd` 删除

## 文件浏览

`<Space><Space>` 打开 fuzzy finder

### Harpoon

在经常使用的文件间快速跳转：

`<Space>H`: 添加文件
`<Space>h`: 查看文件列表，回车跳转
`<Space>1`~`<Space>5`: 快速跳转

### 文件浏览器

- `<Space>e` 打开侧边栏（根目录）
- `<Space>E` 打开侧边栏（当前目录）

浏览：

- `hjkl` 浏览，`<Tab>` 开关目录
- `.` 设置当前根目录，`<bs>` 返回上级目录
- `P` 切换预览
- `s` vsplit 打开，`t` tab 页打开，`S` split 打开
- `[g`/`]g` 定位 git 修改文件

文件操作：

- `a` 新建文件
- `A` 新建目录
- `d` 删除文件
- `r` 重命名
- `y` 复制，`x` 剪切，`p` 粘贴
- `c`/`m` 直接复制/移动到目标路径
- `i` 查看详细信息

搜索：

- `/`/`D` 实时搜索文件/目录
- `f` 按回车才会搜索, `<C-x>` 清空搜索

### grug-far(==TODO==)

查找/替换 `<space>sr`
