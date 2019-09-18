" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :

if exists('g:zl_plugins') && count(g:zl_plugins, 'airline')
    let s:statusline_config = 0
    let s:tabline_config = 0
else
    let s:statusline_config = 1
    let s:tabline_config = 1
endif

if (exists('g:colors_name') && g:colors_name == 'solarized8')
    let s:color_config = 0
else
    let s:color_config = 1
endif

if s:color_config
    hi clear ColorColumn
    hi ColorColumn ctermbg=235 guibg=DarkGrey
    hi clear LineNr
    hi LineNr ctermfg=242 guifg=Grey
endif

" tab栏 {{{

" 始终显示tab栏
set showtabline=2
" 状态栏格式
set tabline=%!MyTabLine()
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XX'
    endif

    return s
endfunction

function! MyTabLabel(tabnr)

    " tabname according to buftype
    let n = ''
    let buflist = tabpagebuflist(a:tabnr)
    let winnr = tabpagewinnr(a:tabnr)
    let nr = buflist[winnr - 1]
    let name = fnamemodify(bufname(nr), ":p:t")
    let type = getbufvar(nr, "&buftype")

    if type == 'help'
        let n .= '[H]' . name
    elseif type == 'quickfix'
        let n .= '[Q]'
    else
        let n .= name
    endif

    " modified counter
    let m = 0
    for b in buflist
        if getbufvar(b, "&modified")
            let m += 1
        endif
    endfor

    let s = a:tabnr . ' '
    if m > 0
        if m == 1
            let s .= '[+]'
        else
            let s .= '[' . m . '+]'
        endif
        let s .= ' '
    endif
    let s .= n

    return s
endfunction
" }}}

" 状态栏 {{{

" 始终显示状态栏
set laststatus=2
" 状态栏格式
if s:statusline_config
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%p%%\ %l/%L,%c%V%) " Right aligned file nav info
endif

set ruler
"set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
set showcmd

" }}}

" 特殊字符显示 {{{
set list
set listchars=tab:›\ ,trail:•,extends:›,nbsp:.
set fillchars=fold:-
" }}}

