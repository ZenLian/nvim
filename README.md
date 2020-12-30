# neovim 配置备忘

## TODO

- [ ] lightline: 仿造 SpaceVim 用 winnr() 显示每个窗口的编号，用 `<leader>{num}` 切换
  - 原来 `<leader>{num}` 切换的是 tab，现在用 `<leader>t{num}切换`

- [ ] incsearch.vim: 实时高亮增强
- [ ] vim-clap 作 fuzzy finder(coc-list 的快捷键移到 clap)
- [ ] vim-which-key: spaceVim 的菜单插件
- [ ] nerd-commenter: 注释、解注释
- [ ] vim-spector 代码调试
- [ ] 调整窗口大小快捷键
- [ ] deol.nvim: vim 终端插件(对比 coc-terminal 决定使用哪个)

- [ ] 图标支持
- [ ] ranger 配置和插件
- [ ] tmux 主题和插件
- [ ] lazygit 尝鲜和 lazygit.vim 集成

准备使用的键位:

- [ ] nmap \<CR\>
- [ ] nmap +,_

## 助记

### 移动

| 快捷键  | 描述       |
| ------- | ---------  |
| `{`/`}` | 跨段落移动 |

### folding

| 快捷键    | 描述              |
| -------   | ---------         |
| `zf`      | 手动创建折叠      |
| `zo`/`zO` | 打开/递归打开折叠 |
| `zc`/`zC` | 关闭/递归关闭折叠 |
| `za`/`zA` | toggle 折叠       |
| `zm`/`zM` | 关闭一个/所有折叠 |
| `zr`/`zR` | 打开一个/所有折叠 |

### help

`gO` 打开大纲

### 窗口

| 快捷键            | 描述             |
| `<C-w>-`/`<C-w>+` | 调整高度         |
| `<C-w><`/`<C-w>>` | 调整宽度         |
| `<C-w>=`          | 自动调整窗口大小 |

### 寄存器

剪切板和宏录制使用的是一样的寄存器
如 `"ay` 复制到 `a` 寄存器，宏录制(`qa{macros}q`录制，`@a`执行)也是录制到 `a`。

- `:reg` 命令可以查看寄存器。
- `"` 临时寄存器，即默认剪切板
- `+`/`*` 系统剪切板
- `"Ay` 可以将复制内容追加到 `a` 寄存器
- Insert 模式下 `<Ctrl-R>` 也可以插入寄存器内容

### 多光标编辑

[vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors) 插件提供
了仿造 sublime-text 的多光标编辑功能，但用起来很别扭，和自动补全很难配合。实际上
vim 原生的支持比插件要强大得多。

**[Vim 不需要多光标编辑功能](https://macplay.github.io/posts/vim-bu-xu-yao-duo-guang-biao-bian-ji-gong-neng)** 这篇文章讲得很全，概括一下：

- 修改多个相同单词：用 `/` 搜索，用 `cgn` 修改下一处，再用 `.` 命令重复
- 修改多行的同一列：用 `<C-V>` 选中块，用 `I` 或 `A` 修改块的首尾
- 多行复杂修改：用宏录制

### mark 标记

- 用 `m` 标记，用 ` 或 ' 跳转
- `''` 跳转到上一处

## 普通按键映射

### leader

| 快捷键  | 描述      |
| ------- | --------- |
| `space` | \<leader> |

## 插件按键映射

### text-obj 系列

text-obj 系列插件，提供了比原生更丰富的 text objects。

| text-obj/快捷键   | 含义                  |
| ----------------- | --------------------- |
| **原生**          |                       |
| w                 | 单词(word)            |
| p                 | 段落(paragraph)       |
| **插件**          |                       |
| f                 | 函数(function)        |
| i                 | 同级缩进(indent)      |
| y                 | 语法高亮区域(syntax)  |
| ,                 | 函数参数(parameter)   |
| *text-obj-uri*    |                       |
| u                 | URI(uri)              |
| `go`              | 在浏览器中打开当前URI |
| *text-obj-python* |                       |
| f                 | 函数(function)        |
| c                 | 类(class)             |
| `[pf`/`]pf`       | 移动到上/下一个函数   |
| `[pc`/`]pc`       | 移动到上/下一个类     |

### vim-expand-region

用 `+`/`_` 根据 textobj 扩展选区

### vim-surround

提供了括号对(如 `""`,`''`,`()`,`[]` )的快捷操作

| 快捷键          | 效果                           | 描述                                   |
| --------------- | ------------------------------ | -------------------------------------- |
| Normal Mode     |                                |                                        |
| `cs"'`          | `"hello"`->`'hello'`           | 修改括号对                             |
| `ds"`           | `"hello"`->`hello`             | 删除括号对                             |
| `ys{text-obj}(` | `{text-obj}`->`( {text-obj} )` | 添加括号对（左括号有空格，右括号没有） |
| Visual Mode     |                                |                                        |
| `S)`            | `{some-text}`->`({some-text})` | 添加括号对                             |

### vim-sneak

用 2 个字符快速定位

| 快捷键      | 描述                                              |
| ----------  | ------------------------------------------------- |
| Normal Mode |                                                   |
| `s{2char}`  | 向前查找两个字符所在位置，然后用 `,`/`;` 前后选择 |
| `S{2char}`  | 向后查找                                          |
| Visual Mode |                                                   |
| `s`/`z`     | 向前/向后                                         |

### tabular

对齐插件

| 快捷键       | 描述    |
| `<leader>==` | 对齐`=` |
| `<leader>=:` | 对齐`:` |

```plaintext
a,aa,aaa
bb,bbb,b
ccc,c,cc
```

执行命令

```plaintext
:Tabularize /,/l0c1
```

变为

```plaintext
a  , aa , aaa
bb , bbb, b
ccc, c  , cc
```

分隔符可以使用正则表达式实现更强大的匹配，详见帮助

### switch.vim

单词快捷切换，按 `-` 触发

详细的切换列表见 https://github.com/AndrewRadev/switch.vim#builtins

- `&&` <-> `||`
- `true` <-> `false`
- c++ 的 `.` <-> `->`

### vim-clap

支持悬浮窗的 fuzzy finder

全部用 `<leader>p` 开头:

- `p`: 列出所有 provider
- `f`: grep files
- `h`: 历史文件
- `c`: 历史命令
- `b`: buffers
- `o`: coc outline
- `d`: coc diagnostic

其他：

- `<C-F>`: 查找当前词

### markdown

| 快捷键    | 描述                  |
|-----------|-----------------------|
| `[[`/`]]` | 上一个/下一个标题     |
| `[]`/`][` | 上一个/下一个同级标题 |
| `]c`/`]u` | 跳到当前标题/父标题   |
| `gx`      | 浏览器中打开链接      |
| `ge`      | vim中打开链接         |

### coc

| 快捷键       | 描述                                                       |
| ---          | ---                                                        |
| `[d`/`]d`    | next/prev 语法错误                                         |
| 列表         |                                                            |
| `<C-p>`      | 搜索文件                                                   |
| `<leader>lm` | 最近使用文件列表                                           |
| `<leader>ly` | yank历史                                                   |
| `<leader>ld` | diagnostic 列表                                            |
| `<leader>lo` | 当前文件 outline                                           |
| `<leader>ls` | 所有工程文件 symbol                                        |
| `<leader>le` | coc 插件列表                                               |
| `<leader>lb` | buffers 列表                                               |
| ...          | ...                                                        |

#### coc-snippets

| 快捷键          | 描述         |
| ---             | ---          |
| `<tab>`         | 补全、展开   |
| `<C-j>`/`<C-k>` | 跳转 snippet |
| `<C-l>`         | 展开 snippet |

#### coc-git

| 快捷键     | 描述             |
| ---------- | ---------------- |
| `[g`/`]g`  | prev/next diff   |
| `gs`       | 查看此处 diff    |
| `gc`       | 查看 commit      |

#### coc-explorer

| 快捷键          | 描述                      |
| ----------      | ----------                |
| `<leader>ef`    | 悬浮窗打开                |
| `<leader>ee`    | 左侧打开                  |
| `<leader>ev`    | 打开 vim 配置目录         |
| `<leader>el`    | 列出可用的浏览器窗口布局  |
| *in explorer*   |                           |
| `<CR>`/`<BS>`   | cd 到下一级/上一级目录    |
| `h`/`l`         | 目录展开/折叠, 打开文件   |
| `e`/`s`/`E`/`t` | open/split/vsplit/tabedit |
| `<Tab>`         | 菜单                      |

