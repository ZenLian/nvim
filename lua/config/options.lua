local options = {
  -- gui
  termguicolors = true,
  mouse = 'a',
  errorbells = false,
  visualbell = false,

  -- encoding
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
  showtabline = 1,
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
  splitkeep = 'screen',
  splitbelow = true,
  splitright = true,
  winwidth = 30,
  winminwidth = 5,
  pumheight = 15,
  helpheight = 12,
  previewheight = 12,
  -- pumblend = 0,
  -- winblend = 0,

  -- timeout
  timeout = true,
  ttimeout = true,
  timeoutlen = 300,
  ttimeoutlen = 0,
  updatetime = 200,
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
  backup = false,
  writebackup = false,
  swapfile = false,
  undofile = true,
  history = 2000,
  clipboard = 'unnamedplus', -- FIXME: causing clipboard.vim a lot of time to find clip tools
  switchbuf = 'useopen',
  viewoptions = 'folds,cursor,curdir,slash,unix',
  sessionoptions = 'curdir,buffers,help,folds,tabpages,winsize,winpos,terminal,globals',

  -- indentation
  smarttab = true,
  shiftround = true,
  expandtab = true,
  autoindent = true,
  smartindent = true,
  tabstop = 4,
  shiftwidth = 0,
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
  grepprg = 'rg --hidden --vimgrep --smart-case --no-heading --',
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

for name, value in pairs(options) do
  vim.opt[name] = value
end
