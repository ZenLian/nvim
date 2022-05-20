local globals = require('core.globals')

vim.g.mapleader = " "

local options = {
    termguicolors = true,
    mouse = "a",
    errorbells = true,
    visualbell = true,
    hidden = true,
    fileformats = "unix,mac,dos",
    magic = true,
    virtualedit = "block",
    encoding = "utf-8",
    viewoptions = "folds,cursor,curdir,slash,unix",
    sessionoptions = "curdir,help,tabpages,winsize",
    -- clipboard = "unnamedplus", -- FIXME: causing clipboard.vim a lot of time to find clip tools
    wildignorecase = true,
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    backup = false,
    writebackup = false,
    swapfile = false,
    directory = globals.cache_dir .. "/swag/",
    undodir = globals.cache_dir .. "/undo/",
    backupdir = globals.cache_dir .. "/backup/",
    viewdir = globals.cache_dir .. "/view/",
    spellfile = globals.cache_dir .. "/spell/en.uft-8.add",
    shadafile = globals.cache_dir .. "/shada",
    history = 2000,
    shada = "!,'300,<50,@100,s10,h",
    backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
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
    complete = ".,w,b,k",
    inccommand = "nosplit",
    grepformat = "%f:%l:%c:%m",
    grepprg = 'rg --hidden --vimgrep --smart-case --',
    breakat = [[\ \	;:,!?]],
    startofline = false,
    whichwrap = "<,>,[,],~",
    splitbelow = true,
    splitright = true,
    switchbuf = "useopen",
    backspace = "indent,eol,start",
    diffopt = "filler,iwhite,internal,algorithm:patience",
    completeopt = "menuone,preview,noinsert",
    jumpoptions = "stack",
    showmode = false,
    shortmess = "aoOTIcF",
    scrolloff = 2,
    sidescrolloff = 5,
    foldlevelstart = 99,
    ruler = true,
    cursorline = true,
    cursorcolumn = false,
    colorcolumn = "121",
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
    laststatus = 2,
    display = "lastline",
    showbreak = "↳  ",
    listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    pumblend = 10,
    winblend = 10,
    autoread = true,
    autowrite = true,

    undofile = true,
    synmaxcol = 2500,
    formatoptions = "1jcroql",
    textwidth = 80,
    expandtab = true,
    autoindent = true,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = -1,
    breakindentopt = "shift:2,min:20",
    wrap = false,
    linebreak = true,
    number = true,
    relativenumber = true,
    foldenable = true,
    signcolumn = "yes",
    conceallevel = 0,
    concealcursor = "niv",
}

local function load_options()
    for name, value in pairs(options) do
        vim.o[name] = value
    end
end

-- don't load these plugins
local disabled_built_plugins = {
    "netrw",
    "netrwPlugin",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    -- "netrwFileHandlers",
    "matchit",
    "loaded_matchparen", -- Highlight matching parens
    "2html_plugin",
}
for _, plugin in ipairs(disabled_built_plugins) do
    vim.g["loaded_" .. plugin] = 1
end

load_options()
