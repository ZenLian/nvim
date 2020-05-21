# neovim 配置备忘

## TODO

- [x] ssh 使用 DISPLAY 导致 xclipboard 极其缓慢(ssh禁用X11 forward)
- [ ] coc-explorer 代替 defx
- [ ] 调整窗口大小快捷键
- [ ] fork code-dark-theme 并修改
- [ ] switch 插件：快速替换单词(`true->false`)
- [ ] nerd-commenter: 注释、解注释
- [x] markdown 插件(vim-markdown, coc-markdownlint)
- [x] coc tab 补全方式改为 vscode 方式: 直接选择第一项然后关闭列表, 如果是 snippets 就展开

准备使用的键位:

- [ ] nmap \<CR\>
- [ ] nmap +,_

## 助记

### 移动

 快捷键  | 描述
 ------- | ---------
`{`/`}`|跨段落移动

### folding

| 快捷键  | 描述      |
| ------- | --------- |
|`zf`|手动创建折叠|
|`zo`/`zO`|打开/递归打开折叠|
|`zc`/`zC`|关闭/递归关闭折叠|
|`za`/`zA`|toggle 折叠|
|`zm`/`zM`|关闭一个/所有折叠|
|`zr`/`zR`|打开一个/所有折叠|

### help

`gO` 打开大纲

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

### defx

文件浏览器

| 快捷键   | 描述                 |
| ---      | ---                  |
| 打开defx |                      |
| `<F3>`   | 打开defx             |
| `<C-e>`  | 打开当前文件所在目录 |
| 打开     |                      |
| `o`      | 展开目录             |
| `h`/`l`  | 上一级/下一级目录    |
| `t`      | tab页中打开          |
| `i`      | 水平分割窗口打开     |
| `v`      | 垂直分割窗口打开     |
| 操作     |                      |
| `c`      | copy                 |
| `m`      | move                 |
| `p`      | paste                |
| `d`      | 删除                 |
| `r`      | 重命名               |
| 显示     |                      |
| `.`      | 显示隐藏文件         |
| `<`/`>`  | 调整窗口大小         |
| 其他     |                      |
| `yy`     | 复制路径名           |
| `\`      | 选中                 |
| `*`      | 全选                 |

### leaderF

模糊搜索

| 快捷键     | 描述             |
| ---------- | ---------------- |
| `<ctrl-p>` | 工作目录文件列表 |
| `<ctrl-n>` | 最近使用文件列表 |
| `<ctrl-f>` | 函数列表         |

### coc

| 快捷键       | 描述                                                       |
| ---          | ---                                                        |
| `[d`/`]d`    | next/prev 语法错误                                         |
| 文字搜索     |                                                            |
| `<C-f>`      | 全局搜索字符串(visual 模式下非 regex, normal 模式下 regex) |
| `-`          | 当前buffer搜索当前字符串                                   |
| `<leader>-`  | 当前buffer搜索(regex)                                      |
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
