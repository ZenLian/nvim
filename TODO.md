# TODO

## 启动页

编辑器启动界面，暂时不需要，用前者：

- [ ] alpha-nvim
- [ ] dashboard

## 文件浏览

- [x] nvim-tree keymaps
- [ ] is0n/fm-nvim 和 telescope 文件浏览器比较
- [ ] telescope 文件浏览器改为 ranger 风格

## Telescope

- [ ] telescope-symbols.nvim 列出特殊符号(emoji/数学符号等)
- [ ] telescope UI 美化

## Git

- [x] gitsigns
- [x] toggleterm
  - [x] lazygit(in toggleterm)
- [ ] neogit - 来自于 emacs 的 magit，专注于git工作流，提供最符合 vim 哲学的 git 操作。可以尝试。

## LSP

### 代码结构

- [x] aerial.nvim
- [ ] ~~symbols-outline~~ 暂时先用前者

用 `<C-s>` 开关

### 函数签名

- [x] ~~lsp_signature ~~ 改用 nvim-cmp-signature-help

### 基本功能

- [ ] trouble.nvim 底部列表，主要是错误诊断信息

`:Trouble [mode]` 调出，可以显示错误诊断/函数定义等，暂时还没有设快捷键

更好用的 lsp 功能，三选一：

- [ ] nvim-lsputils - LSP 功能优化
- [x] lspsaga.nvim - 为 LSP 提供一个轻量级的 UI，用这个足够了
- [ ] navigator.lua - 功能很强大，什么都不需要配置就可以得到 IDE 级别的 LSP 支持，但侵入性太强

### UI 界面

- [x] lspkind.nvim 提供类 vscode 的补全图标
- [ ] fidget.nvim 提供一个独立的 LSP 加载进度 UI

### 其他 LSP 相关

- [ ] nlsp-settings.nvim 用 json 配置 lsp
- [ ] null-ls. 作为一个中间桥梁，让非 LSP 源能够执行neovim 内的 LSP 操作(格式化等)，比如用 prettier 格式化代码

## 调试运行

- [ ] nvim-dap

## 优化启动速度

- filetype.nvim
- impatient.nvim
- 禁用多余的vim功能（netrw等）

## 其他

- todo-comments TODO 注释的高亮和查找(telescope/trouble列表)
- [ ] gpanders/editorconfig.nvim 为每个项目使用单独的编辑器设置（缩进等）
- [ ] glow.nvim 直接在终端预览 markdown
- [ ] which-key 键位整理
