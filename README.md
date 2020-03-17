# neovim 配置备忘

## TODO

- [ ] fork code-dark-theme 并修改
- [ ] switch 插件：快速替换单词(`true->false`)
- [ ] nerd-commenter: 注释、解注释
- [ ] markdown 插件(vim-markdown, coc-markdownlint)
- [ ] coc tab 补全方式改为 vscode 方式: 直接选择第一项然后关闭列表, 如果是 snippets 就展开
- [ ] coc-git blame 不显示???

准备使用的键位:

- [ ] nmap <CR>
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

`g0` 打开大纲

### 寄存器
剪切板和宏录制使用的是一样的寄存器
如 `"ay` 复制到 `a` 寄存器，宏录制(`qa{macros}q`录制，`@a`执行)也是录制到 `a`。

- `:reg` 命令可以查看寄存器。
- `"` 临时寄存器，即默认剪切板
- `+`/`*` 系统剪切板
- `"Ay` 可以将复制内容追加到 `a` 寄存器
- Insert 模式下 `<Ctrl-R>` 也可以插入寄存器内容

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

```
a,aa,aaa
bb,bbb,b
ccc,c,cc
```

执行命令

```
:Tabularize /,/l0c1
```

变为

```
a  , aa , aaa
bb , bbb, b
ccc, c  , cc
```

分隔符可以使用正则表达式实现更强大的匹配，详见帮助

### nerdtree

文件树操作

| 快捷键           | 描述                           |
| ---------------- | ------------------------------ |
| `f2`             | 打开/关闭nerdtree              |
| 打开             |                                |
| `o`              | 打开                           |
| `t`              | tab页中打开                    |
| `i`              | 水平分割窗口打开               |
| `s`              | 垂直分割窗口打开               |
| 移动             |                                |
| `<ctrl>`+`j`/`k` | 移动到相邻同级节点             |
| `J`/`K`          | 移动到同级节点首/尾            |
| `P`              | 移动到父节点                   |
| `p`              | 移动到根节点                   |
| 目录             |                                |
| `C`              | 进入选定目录                   |
| `u`              | 进入上级目录                   |
| `m`              | 打开菜单（节点的增删复制移动） |
| 自定义           |                                |
| `<leader>nf`     | 定位当前文件                   |

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

#### coc-git

| 快捷键     | 描述             |
| ---------- | ---------------- |
| `[g`/`]g`  | prev/next diff   |
| `gs`       | 查看此处 diff    |
| `gc`       | 查看 commit      |
