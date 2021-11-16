# neovim lua 配置

neovim 0.5.0 开始使用原生支持 lua 配置，并且内置 lsp 和 treesitter
等特性，比 coc.nvim 要快，不需要大量的 node 依赖。准备将原来的 coc 配置一点点迁移过来了。

- 使用 packer.nvim 替代 vim-plug
- 使用 lspconfig 替代 coc.nvim
