local config = require('config').config
local cache_dir = config.dirs.cache

local options = {
  termguicolors = true,
  mouse = 'a',
  errorbells = false,
  visualbell = false,

  hidden = true,
  fileformats = 'unix,mac,dos',
  encoding = 'utf-8',

  -- ui
  -- left
  number = true,
  relativenumber = true,
  signcolumn = 'yes',
  foldcolumn = '0',
  foldenable = true,
  foldlevelstart = 99,
  -- inside
  cursorline = true,
  cursorcolumn = false,
  colorcolumn = '121',
  -- top
  showtabline = 2,
  -- bottom
  laststatus = 3, -- global statusline
  ruler = true,
  cmdheight = 1,
  cmdwinheight = 5,
  showcmd = true,
  showmode = false,
  wildignorecase = true,
  wildignore = [[.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,]]
    .. [[**/node_modules/**,**/bower_modules/**]],

  -- windows
  splitbelow = true,
  splitright = true,
  winwidth = 30,
  -- winminwidth = 10,
  pumheight = 15,
  helpheight = 12,
  previewheight = 12,
  pumblend = 10,
  winblend = 10,

  -- timeout
  timeout = true,
  ttimeout = true,
  timeoutlen = 300,
  ttimeoutlen = 0,
  updatetime = 100,
  redrawtime = 1500,
  lazyredraw = false,

  -- search
  ignorecase = true,
  smartcase = true,
  infercase = true,
  incsearch = true,
  wrapscan = true,
  magic = true,
  inccommand = 'split',

  -- files
  autoread = true,
  autowrite = true,
  viewoptions = 'folds,cursor,curdir,slash,unix',
  sessionoptions = 'curdir,buffers,help,folds,tabpages,winsize,winpos,terminal,globals',
  -- clipboard = "unnamedplus", -- FIXME: causing clipboard.vim a lot of time to find clip tools
  backup = false,
  writebackup = false,
  swapfile = false,
  undofile = true,
  directory = cache_dir .. '/swag/',
  undodir = cache_dir .. '/undo/',
  backupdir = cache_dir .. '/backup/',
  viewdir = cache_dir .. '/view/',
  spellfile = cache_dir .. '/spell/en.uft-8.add',
  shadafile = cache_dir .. '/shada',
  history = 2000,
  shada = "!,'300,<50,@100,s10,h",
  backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim',
  switchbuf = 'useopen',

  -- indentation
  smarttab = true,
  shiftround = true,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = -1,

  -- text
  virtualedit = 'block',
  whichwrap = '<,>,[,],~',
  backspace = 'indent,eol,start',
  breakindentopt = 'shift:2,min:20',
  wrap = false,
  linebreak = true,
  breakat = [[\ \	;:,!?]],
  showbreak = '↳  ',
  display = 'lastline',
  listchars = [[tab:→ ,nbsp:+,trail:·,extends:→,precedes:←]],

  complete = '.,w,b,k',
  grepformat = '%f:%l:%c:%m',
  grepprg = 'rg --hidden --vimgrep --smart-case --',
  startofline = false,
  diffopt = 'filler,iwhite,internal,algorithm:patience',
  completeopt = 'menuone,preview,noinsert',
  jumpoptions = 'stack',
  shortmess = 'aoOTIcF',
  scrolloff = 5,
  sidescrolloff = 10,
  list = true,
  equalalways = false,
  synmaxcol = 2500,
  formatoptions = '1jcroql',
  textwidth = 80,
  conceallevel = 0,
  concealcursor = 'niv',
}

-- load_options
for name, value in pairs(options) do
  vim.o[name] = value
end

vim.g.mapleader = ' '

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
  -- 'matchparen', -- Highlight matching parens
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
if vim.fn.glob(config.provider.python3) ~= '' then
  vim.g.python3_host_prog = config.provider.python3
end
