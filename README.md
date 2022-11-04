# 😽 Neovim lua config

![screenshot](https://raw.githubusercontent.com/ZenLian/imglib/main/202211050611008.png)

## 👀 Prerequisite

- neovim v0.8+
- fzf
- ripgrep
- fd
- sqlite3
- [deno](https://deno.land/)(optional, for [peek.nvim](https://github.com/toppair/peek.nvim))

## 🔌 Plugins

### 🖼️ UI

| Plugin                                                                          | Description                              |
| ------------------------------------------------------------------------------- | ---------------------------------------- |
| [nvdark.nvim](https://github.com/ZenLian/nvdark.nvim)                           | colorscheme like vscode dark+            |
| [windline.nvim](https://github.com/windwp/windline.nvim)                        | status line                              |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                   | buffer/tab line                          |
| [alpha-nvim](https://github.com/goolord/alpha-nvim)                             | greeter                                  |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | visualized indent line                   |
| [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)            | color highlighter                        |
| [vim-illuminated](https://github.com/RRethy/vim-illuminate)                     | highlight cursor word                    |
| [zen-mode.nvim](https://github.com/folke/zen-mode.nvim)                         | focus mode                               |
| [twilight.nvim](https://github.com/folke/twilight.nvim)                         | focus on current code block              |
| [nvim-notify](https://github.com/rcarriga/nvim-notify)                          | pretty `vim.notify`                      |
| [dressing.nvim](https://github.com/stevearc/dressing.nvim)                      | pretty `vim.ui.input` && `vim.ui.select` |

### 🛠️ Tools

#### 🔭 Telescope and extensions

| Plugin                                                                                         | Description                 |
| ---------------------------------------------------------------------------------------------- | --------------------------- |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                             | fuzzy finder                |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)       | speed up telescope with fzf |
| [telescope-frecency.nvim](https://github.com/nvim-telescope/telescope-frecency.nvim)           | MRU files                   |
| [telescope-smart-history.nvim](https://github.com/nvim-telescope/telescope-smart-history.nvim) | smart history search        |
| [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)   | file browser                |
| [nvim-neoclip.lua](https://github.com/AckslD/nvim-neoclip.lua)                                 | clipboard search            |

#### Others

| Plugin                                                                     | Description                        |
| -------------------------------------------------------------------------- | ---------------------------------- |
| [neovim-session-manager](https://github.com/Shatur/neovim-session-manager) | save/load sessions                 |
| [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)               | file tree                          |
| [undotree](https://github.com/jiaoshijie/undotree)                         | visualize undotree                 |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)              | manage terminals                   |
| [diffview.lua](https://github.com/sindrets/diffview.nvim)                  | pretty diffview                    |
| [neogit](https://github.com/TimUntersberger/neogit)                        | git operations                     |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)          | highlight and search todo comments |
| [which-key.nvim](https://github.com/folke/which-key.nvim)                  | keymap popup and management        |
| [vim-startuptime](https://github.com/dstein64/vim-startuptime)             | measure vim startup time           |
| [impatient.nvim](https://github.com/lewis6991/impatient.nvim)              | improve vim startup time           |

### ✒️ Editor

Treesitter

| Plugin                                                                                       | Description                                                           |
| -------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                        | base plugin for neovim's built-in tree-sitter(language syntax parser) |
| [playground](https://github.com/nvim-treesitter/playground)                                  | inspect treesitter structure                                          |
| [nvim-treesitter-textobject](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) | textobject                                                            |
| [nvim-treesitter-context](https://github.com/lewis6991/nvim-treesitter-context)              | fixed context header                                                  |
| [nvim-treehopper](https://github.com/mfussenegger/nvim-treehopper)                           | fast range selection                                                  |
| [nvim-ts-rainbow](https://github.com/p00f/nvim-ts-rainbow)                                   | rainbow brackets                                                      |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim)                                     | fast comment/uncomment                                                |
| [surround.nvim](https://github.com/ur4ltz/surround.nvim)                                     | fast surround brackets                                                |
| [lightspeed.nvim](https://github.com/ggandor/lightspeed.nvim)                                | fast movement                                                         |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim)                                       | visualized git signs                                                  |
| [editorconfig.nvim](https://github.com/gpanders/editorconfig.nvim)                           | editorconfig                                                          |

### 🔥 Completion

| Plugin                                                                   | Description                                                 |
| ------------------------------------------------------------------------ | ----------------------------------------------------------- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)               | lsp config                                                  |
| [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer) | install lsp servers                                         |
| [lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim)        | signature help                                              |
| [lua-dev.nvim](https://github.com/folke/lua-dev.nvim)                    | nvim's lua development env                                  |
| [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)       | format/lint source provider                                 |
| [schemastore.nvim](https://github.com/b0o/schemastore.nvim)              | schemas provider                                            |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                          | completion framework(with tons of sources, not listed here) |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs)               | autopairs                                                   |
| [aerial.nvim](https://github.com/stevearc/aerial.nvim)                   | symbols outline                                             |
| [trouble.nvim](https://github.com/folke/trouble.nvim)                    | pretty diagnostic list                                      |

### 📔 Markdown

| Plugin                                            | Description  |
| ------------------------------------------------- | ------------ |
| [peek.nvim](https://github.com/toppair/peek.nvim) | live preview |

## Workflows

## ❤️ Credits

- [ayamir/nvimdots](https://github.com/ayamir/nvimdots)
- [folke/dot](https://github.com/folke/dot/tree/master/config/nvim)
