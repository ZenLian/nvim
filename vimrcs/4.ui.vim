" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :

if exists('g:zl_plugins') && count(g:zl_plugins, 'airline')
    let s:statusline_config = 0
    let s:tabline_config = 0
else
    let s:color_config = 1
endif

if (exists('g:colors_name') && g:colors_name == 'solarized8')
    let s:color_config = 0
else
    let s:color_config = 1
endif

" tab栏 {{{
" 始终显示tab栏
set showtabline=2
" }}}

" 状态栏 {{{
" 始终显示状态栏
set laststatus=2
if s:statusline_config
" 状态栏格式
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif
" }}}

" cmdline_info {{{
    set ruler
    "set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
" }}}

" 特殊字符显示 {{{
set list
set listchars=tab:›\ ,trail:•,extends:›,nbsp:.
" }}}

" 分割窗口位置 {{{
set splitbelow
set splitright
" }}}

