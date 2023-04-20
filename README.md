# 😽 Neovim lua config

![screenshot](https://raw.githubusercontent.com/ZenLian/imglib/main/202211050611008.png)

## 👀 Prerequisite

- neovim v0.8+
- ripgrep
- fd
- sqlite3

## 🔌 Plugins

### Requirements

- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [sqlite.lua](https://github.com/kkharji/sqlite.lua)

### 🖼️ UI

| Plugin                                                                          | Description                              |
| ------------------------------------------------------------------------------- | ---------------------------------------- |
| [catppuccin](https://github.com/catppuccin/nvim)                                | colorscheme                              |
| [rebelot/heirline.nvim](https://github.com/rebelot/heirline.nvim)               | statusline/winbar                        |
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
| [neo-tree.lua](https://github.com/nvim-neo-tree/neo-tree.nvim)             | file explorer                      |
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
| [nvim-ts-rainbow2](https://github.com/p00f/HiPhish/nvim-ts-rainbow2)                         | rainbow brackets                                                      |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim)                                     | fast comment/uncomment                                                |
| [surround.nvim](https://github.com/ur4ltz/surround.nvim)                                     | fast surround brackets                                                |
| [leap.nvim](https://github.com/ggandor/lightspeed.nvim)                                      | fast movement                                                         |
| [gitsigns](https://github.com/lewis6991/gitsigns.nvim)                                       | visualized git signs                                                  |

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

## 🚀 Workflows

### ✏️ Edit

#### 🚶 Movement

- Never repeat `hjkl` more than 3 times!!!
- Use `f`/`F`/`t`/`T` for inline movement, then `,`/`;` to choose.
- Use `/`/`?` to search words for cross line movement, then `n`/`N` to choose.
- with leap.nvim, you can jump to anywhere in vision:
  - Normal mode: `s`/`S` followed by 2 chars
  - Visual mode: `x`/`X` followed by 2 chars
  - `r` motion on remote textobject(e.g. `yarp` to "yank a remote paragraph")

tips:

- Press `<C-O>` in insert mode, temporarily switching to normal mode for one movement.

#### 🥄 Selection

textobjects:

- pairs
  - digit (`0`-`9`)
  - punctuation (`_`, `*`, `,`, etc.)
  - whitespace (space, tab, etc.)
- `b`: bracket, alias for `)`, `]` or `}`
- `q`: quote, alias for `'`, `"` or ```
- `t`: tag, e.g. `<h1></h1>`
- `f`: function
- `a`: argument/parameter
- `c`: class
- `g`: git hunk
- `j`/`k`: next/last textobjects(never used!)
- customs
  - [x] `e`: whole buffer
  - [x] `u`: url
  - [x] `/`: comment
  - [x] `i`: indent
- not used: `rydhlzxvnm`

treesitter nodes:

- Normal Mode:
  - `vn`: select current node
  - `vx`: select parent node(never used)
  - `vd`/`vu`: swap current node with next/previous sibling
  - `vD`/`vU`: swap parent node with next/previous sibling(never used)
- Visual Mode:
  - `J`/`K`: select next/previous sibling node
  - `H`/`L`: select parent/child node
  - `<A-d>`/`<A-u>`\*\*: swap nodes
  - `m`: label-based selection
  - `+`/`-` incremental/decremental selection

#### 📓 Text Edit

surround:

- `ys{motion})` insert `()` surround `{motion}`
- `ds{motion}` delete surround `{motion}`
- Visual mode: `s)` to insert `()`
  clipboard management:

clipboard:

- `[p`/`]p` paste before/after as block
- `<A-]>`/`<A-]>` cycle clipboard
- `<Leader>iy` select from clipboard(yank history)

quick switches:

- `<C-a>`/`<C-x>` can switch words like `true`/`false`, `Monday`/`Tuesday` etc.

interactive insert:

- `<Leader>is` symbols

tips:

- Insert Mode:
  - `<C-K>{1or2char}` to insert digraphs(`:digraphs`), e.g. `<C-k>vv` insert `│`.
  - `<C-V><Tab>` to insert actual Tab.
  - `<C-R>` insert a register content, e.g. `<C-R>+` to insert clipboard content.

### 📁 File Explorer

#### neo-tree

- `<C-e>` open/focus neo-tree
- `<Leader>e` toggle neo-tree

Inside explorer navigation:

- `.`/`<bs>` cd/navigate up
- `h'/'j'/'k'/'l` navigate/open files
- `<c-v>`/`<c-s>`/`<c-t>` open in vsplit/split/tab
- `<`/`>` switch source(file, buffer, git)

file actions:

- `a` add file or directory(end with `/`)
- `A` add directory
- `d` delete
- `r` rename
- `y` copy
- `x` cut
- `p` paste

search:

- `/` to search file, `<C-n>`/`<C-p>` to choose, and `<enter>` to open
- `sf`/`sg` to find/grep in current node

view changes:

- `zR`: expand all
- `zM`: close all
- `<tab>`: toggle node
- `H`: toggle hidden
- `R`: refresh
- [ ] `zh`: toggle dotfiles
- [ ] `zg`: toggle gitignored files

#### drex

> open directories in buffer and modify like normal text

- `<Leader>d` toggle drex drawer
- `<Leader>D` open drex buffer

navigation:

- `h`/`j`/`k`/`l`/`<CR>`: basic navigation
- `<Tab>`: toggle directory
- `-`/`.`: goto parent/child directory
- `~`: goto home
- `<C-v>`/`<C-s>`/`<C-t>` open in vsplit/split/tab
- `<C-r>`: reload

clipboard:

- `m`: toggle mark
- `M`: mark
- `u`: unmark
- `U`: unmark all
- `c`: edit clipboard

file actions:

- `s`: show file stats
- `a`/`A`: create file or directory, `A` to create inside cursor directory
- `d`: delete current elements
- `D`: delete all in clipboard
- 't': trash current elements
- 'T': trash all in clipboard
- `p`: copy all in clipboard to cursor position
- `P`: move all in clipboard to cursor position
- 'r': rename current elements
- 'R': rename all in clipboard

strings:

- `y`: copy name
- `Y`: copy relative path
- `<C-y>`: copy absolute path

### 🔎 Search

search for files/text:

- `<C-p>` search git files
- `<Leader>ff` search files
- `<Leader>fr` search recent files
- `<Leader>fh` search frecency files
- `<Leader>fb` search buffers
- `<Leader>fg` live grep in workspace
- `<Leader>fw` search current word in workspace
- `<C-f>`/`<Leader>fz` search in current buffer

### 🔖 Git

Git keymaps mostly start with `<Leader>g`.

- `[g`/`]g` previous/next git hunk
- `<Leader>gg` open neogit(**most frequently used**)
- `<Leader>gl` open lazygit
- `<Leader>gd` open diffview

- `<Leader>gD` diff current file
- `<Leader>gb` blameline
- `<Leader>gp` preview inline
- `<Leader>gP` preview in popup window
- `<Leader>gq` send to quickfix
- `<Leader>gh` operations related to git hunks

- `<Leader>gB` explore git branches
- `<Leader>gC` explore git commits
- `<Leader>gs` explore git status

Inside neogit:

- `<tab>` close/expand groups
- `1`/`2`/... set fold level
- `s`/`S` stage current/stage all
- `u`/`U` unstage current/unstage all
- `c` commit
- `p` pull
- `P` Push

### 🛠️ Languages

#### ⚙️ LSP

- `gd`: goto definition
- `gr`: goto references
- `gR`: list references in Trouble

- `<Leader>lf`: format
- `<Leader>la`: code action
- `<Leader>lr`: lsp rename

- `<Leader>ld`: show line diagnostics
- `<Leader>lD`: list diagnostics in Trouble

- `[d`/`]d`: previous/next diagnostic
- `[e`/`]e`: previous/next diagnostic error

#### ⬇️ Markdown

- `<Leader>lp`: preview(glow)
- `<Leader>lP`: live preview(peek)
- `<Leader>li`: edit code block(nvim-FeMaCo)
  - same as `i_<C-l>`

## ❤️ Credits

- [ayamir/nvimdots](https://github.com/ayamir/nvimdots)
- [folke/dot](https://github.com/folke/dot/tree/master/config/nvim)
