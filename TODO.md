# TODO

## 启动页

- [ ] alpha-nvim
- [ ] dashboard

用前者。

## 文件浏览

- [x] nvim-tree keymaps
- [ ] is0n/fm-nvim 和 telescope 文件浏览器比较
- [ ] telescope 文件浏览器改为 ranger 风格

## Telescope

- [ ] telescope-symbols.nvim 列出特殊符号(emoji/数学符号等)

## Git

- [x] gitsigns
- [x] toggleterm
  - [x] lazygit(in toggleterm)
- [ ] neogit - 可以尝试，专注于 git 工作流

## LSP

### 代码结构

- [x] aerial.nvim
- [ ] ~~symbols-outline~~ 暂时先用前者

用 `<C-s>` 开关

### 函数签名

- [x] ~~lsp_signature ~~ 改用 nvim-cmp-signature-help

### 基本功能

- [ ] trouble.nvim 底部列表，主要是错误诊断信息

`:Trouble [mode]` 调出，可以显示错误诊断/函数定义等，暂时没设快捷键

- [ ] nvim-lsputils, lspsaga.nvim, navigator.lua 3 选 1，更好用的 lsp 功能

### 其他 LSP 相关

- [ ] nlsp-settings.nvim

## 调试运行

- [ ] nvim-dap

## 其他

- neogit。来自于 emacs 的 magit，专注于git工作流，提供最符合 vim 哲学的 git 操作。可以尝试。
- null-ls. 作为一个中间桥梁，让非 LSP 源能够执行neovim 内的 LSP 操作(格式化等)，比如用 prettier 格式化代码
- todo-comments TODO 注释的高亮和查找(telescope/trouble列表)

---

- [ ] dashboard.nvim 编辑器界面，暂时不需要
- [ ] folke/todo-comments.nvim
- [ ] gpanders/editorconfig.nvim 为每个项目使用单独的编辑器设置（缩进等）

- [x] which-key 键位整理
