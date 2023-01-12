local M = {}

local config = require('config')
local cache_dir = config.dirs.cache

-- Better quickfix ui
-- https://github.com/kevinhwang91/nvim-bqf#format-new-quickfix
function _G.qftf(info)
  local fn = vim.fn
  local items
  local ret = {}
  -- The name of item in list is based on the directory of quickfix window.
  -- Change the directory for quickfix window make the name of item shorter.
  -- It's a good opportunity to change current directory in quickfixtextfunc :)
  --
  -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
  -- local root = getRootByAlterBufnr(alterBufnr)
  -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
  --
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
  local validFmt = '%s │%5d:%-3d│%s %s'
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ''
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == '' then
          fname = '[No Name]'
        else
          fname = fname:gsub('^' .. vim.env.HOME, '~')
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

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
  -- quickfix
  -- qftf = '{info -> v:lua.require"config.options".qftf(info)}',
  quickfixtextfunc = '{info -> v:lua._G.qftf(info)}',

  -- windows
  splitbelow = true,
  splitright = true,
  winwidth = 30,
  -- winminwidth = 10,
  pumheight = 15,
  helpheight = 12,
  previewheight = 12,
  pumblend = 0,
  winblend = 0,

  -- timeout
  timeout = true,
  ttimeout = true,
  timeoutlen = 300,
  ttimeoutlen = 0,
  updatetime = 100,
  redrawtime = 1500,
  lazyredraw = true,

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
  spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add',
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

function M.setup()
  -- load_options
  for name, value in pairs(options) do
    vim.o[name] = value
  end
  -- disable builtin plugins
  for _, plugin in ipairs(builtin_plugins) do
    vim.g['loaded_' .. plugin] = 1
  end
  -- virtual env provider
  if vim.fn.glob(config.provider.python3) ~= '' then
    vim.g.python3_host_prog = config.provider.python3
  end
end

return M
