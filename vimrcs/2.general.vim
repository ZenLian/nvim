" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :
filetype plugin indent on
syntax enable on

set encoding=utf8
set autoread " 自动读入文件变化
set autochdir " 自动切换工作目录
"set mouse=a " 自动检测鼠标，不推荐
set mousehide " 隐藏鼠标
" set foldcolumn " 左侧留一列空白
set scrolloff=5 " 滚动时光标离上下边界的距离
"set scrolljump=3 " 一次滚动的行数
set cursorline " 高亮当前行
set colorcolumn=81 " 单行长度警戒线
"set termguicolors " 终端也显示gui颜色
set hidden " 允许未保存的 buffer 隐藏

" 文本和缩进 {{{
"set whichwrap+=h,l,<,> " 方向键跨行，不推荐
set backspace=indent,eol,start " 正常的退格键
set shiftwidth=4 " 缩进宽度
set tabstop=4 " tab宽度
set expandtab " 空格代替tab
set smarttab
set autoindent
set smartindent
set nowrap " 不自动换行
" }}}

" 行号 {{{
set relativenumber number
" FIXME: 终端下无效，用BufEnter和BufLeave代替
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" FIXME: 本无行号的buffer在离开后会显示行号
"au BufLeave * :set norelativenumber number
"au BufEnter * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对行号
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
" 切换绝对/相对行号
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber number
    else
        set relativenumber
    endif
endfunc
"nnoremap <C-n> :call NumberToggle()<cr>
" }}}

" 永久记住修改历史 {{{
if has('persistent_undo')
    if has('nvim')
        set undodir=~/.local/share/nvim/undo
    else
        set undodir=~/.vim/tmp/vimundo
    endif
    set undolevels=1000
    set undoreload=10000
    set undofile
endif
" }}}

" 关闭备份 {{{
set nobackup
set nowritebackup
set noswapfile
" }}}

" viminfo文件 {{{
if !has('nvim')
    set viminfofile=~/.vim/tmp/viminfo
endif
" }}}

" 搜索 {{{
set hlsearch " 高亮搜索结果
set incsearch " 实时高亮
set ignorecase " 忽略大小写
set smartcase " 检测到大写时切换为大小写敏感
" }}}

" autocmd {{{
" 打开文件时自动跳转至上次编辑处
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 无可编辑buffer时自动退出
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif

" 保存时自动删除行末空格
function! StripTrailingSpace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * call StripTrailingSpace()
" }}}

