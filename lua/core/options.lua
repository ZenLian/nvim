local cache_dir = require('core.util').paths.cache
local config = require('config')

local options = {
  termguicolors = true,
  mouse = 'a',
  errorbells = true,
  visualbell = true,
  hidden = true,
  fileformats = 'unix,mac,dos',
  magic = true,
  virtualedit = 'block',
  encoding = 'utf-8',
  viewoptions = 'folds,cursor,curdir,slash,unix',
  -- sessionoptions = 'curdir,buffers,help,tabpages,winsize',
  -- sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal',
  -- clipboard = "unnamedplus", -- FIXME: causing clipboard.vim a lot of time to find clip tools
  wildignorecase = true,
  wildignore = [[.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,]]
    .. [[**/node_modules/**,**/bower_modules/**]],
  backup = false,
  writebackup = false,
  swapfile = false,
  directory = cache_dir .. '/swag/',
  undodir = cache_dir .. '/undo/',
  backupdir = cache_dir .. '/backup/',
  viewdir = cache_dir .. '/view/',
  spellfile = cache_dir .. '/spell/en.uft-8.add',
  shadafile = cache_dir .. '/shada',
  history = 2000,
  shada = "!,'300,<50,@100,s10,h",
  backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim',
  smarttab = true,
  shiftround = true,
  timeout = true,
  ttimeout = true,
  timeoutlen = 300,
  ttimeoutlen = 0,
  updatetime = 100,
  redrawtime = 1500,
  ignorecase = true,
  smartcase = true,
  infercase = true,
  incsearch = true,
  wrapscan = true,
  complete = '.,w,b,k',
  inccommand = 'nosplit',
  grepformat = '%f:%l:%c:%m',
  grepprg = 'rg --hidden --vimgrep --smart-case --',
  breakat = [[\ \	;:,!?]],
  startofline = false,
  whichwrap = '<,>,[,],~',
  splitbelow = true,
  splitright = true,
  switchbuf = 'useopen',
  backspace = 'indent,eol,start',
  diffopt = 'filler,iwhite,internal,algorithm:patience',
  completeopt = 'menuone,preview,noinsert',
  jumpoptions = 'stack',
  showmode = false,
  shortmess = 'aoOTIcF',
  scrolloff = 2,
  sidescrolloff = 5,
  foldlevelstart = 99,
  ruler = true,
  cursorline = true,
  cursorcolumn = false,
  colorcolumn = '121',
  list = true,
  showtabline = 2,
  winwidth = 30,
  winminwidth = 10,
  pumheight = 15,
  helpheight = 12,
  previewheight = 12,
  showcmd = false,
  cmdheight = 2,
  cmdwinheight = 5,
  equalalways = false,
  laststatus = 3, -- global statusline
  display = 'lastline',
  showbreak = '↳  ',
  listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←',
  -- pumblend = 10,
  winblend = 10,
  autoread = true,
  autowrite = true,

  undofile = true,
  synmaxcol = 2500,
  formatoptions = '1jcroql',
  textwidth = 80,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = -1,
  breakindentopt = 'shift:2,min:20',
  wrap = false,
  linebreak = true,
  number = true,
  relativenumber = true,
  foldenable = true,
  signcolumn = 'yes',
  conceallevel = 0,
  concealcursor = 'niv',
}

-- load_options
for name, value in pairs(options) do
  vim.o[name] = value
end

vim.g.mapleader = ' '

-- use filetype.lua instead of filetype.vim
-- https://neovim.io/news/2022/04, #filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- don't load these plugins
local builtin_plugins = {
  '2html_plugin',
  'getscript',
  'getscriptPlugin',
  'gzip',
  'logipat',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'matchit',
  'matchparen', -- Highlight matching parens
  'tar',
  'tarPlugin',
  'rrhelper',
  'spellfile_plugin',
  'vimball',
  'vimballPlugin',
  'zip',
  'zipPlugin',
}

for _, plugin in ipairs(builtin_plugins) do
  vim.g['loaded_' .. plugin] = 1
end

-- virtual env provider
if not vim.fn.empty(vim.fn.glob(config.provider.python3)) then
  vim.g.python3_host_prog = config.provider.python3
end
