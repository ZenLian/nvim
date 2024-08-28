# 😽 Neovim lua config

Neovim configuration powered by [LazyVim](https://github.com/LazyVim/LazyVim).

![screenshot](https://raw.githubusercontent.com/ZenLian/imglib/main/202211050611008.png)

## 代码编辑

### text-objects(mini.ai)

- `d` 数字
- `g` 全选
- `t` tag
- `i` 缩进
- `o` 代码块（如 `if`、`for`）
- `f` **f**unction
- `c` **c**lass
- `u` function 调用(**u**sage)

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


