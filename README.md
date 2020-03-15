# neovim 配置备忘

## TODO

- [ ] taglist 快捷键
- [ ] fork code-dark-theme 并修改

## 助记

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
| `cs"'`          | `"hello"`->`'hello'`           | 修改括号对                             |
| `ds"`           | `"hello"`->`hello`             | 删除括号对                             |
| `ys{text-obj}(` | `{text-obj}`->`( {text-obj} )` | 添加括号对（左括号有空格，右括号没有） |

### vim-sneak

用 2 个字符快速定位

| 快捷键     | 描述                                              |
| ---------- | ------------------------------------------------- |
| `s{2char}` | 向前查找两个字符所在位置，然后用 `,`/`;` 前后选择 |
| `S{2char}` | 向后查找                                          |

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



