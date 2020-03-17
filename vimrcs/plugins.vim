" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=99 :

let mapleader = "\<Space>"

if !exists('g:zl_plugins')
    let g:zl_plugins=['basics']
endif

if has('nvim')
    let s:plug = expand('~/.local/share/nvim/plug')
else
    let s:plug = expand('~/.vim/bundle')
endif

" load plugins {{{
call plug#begin(s:plug)

" 编辑辅助 {{{
    " basics
    "Plug 'jiangmiao/auto-pairs'
    "    let g:AutoPairsShortcutToggle = '<M-a>'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    "Plug 'easymotion/vim-easymotion'
    Plug 'godlygeek/tabular'

    " textobj
    " TODO: 用 coc-textobj 替代
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'kana/vim-textobj-syntax'
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
    Plug 'sgur/vim-textobj-parameter'
    Plug 'bps/vim-textobj-python', {'for': 'python'}
    Plug 'jceb/vim-textobj-uri'
" }}}

" lists(tags/yanks) {{{
if executable('ctags')
    " 自动生成 tags 文件
    if has('nvim') || v:version >= 800
        Plug 'ludovicchabant/vim-gutentags'
    endif
    Plug 'liuchengxu/vista.vim'
endif
    " yank历史
    Plug 'junegunn/vim-peekaboo'
" }}}

" NERDTree {{{
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"}}}

" 用 coc-list 代替
" fuzzy find {{{
    "Plug 'Yggdroot/LeaderF'
"Plug 'Shougo/denite.nvim' " 功能强大，配置复杂
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
" }}}

" 用 coc 代替
" 语法 {{{
    " 语法检查
    "Plug 'neomake/neomake'
    "Plug 'w0rp/ale'
    " 代码格式化
    "Plug 'sbdchd/neoformat'
" }}}

" TODO: coc-git 功能完善后删除
" git {{{
" git-gutter
" }}}

" 代码补全 {{{
if 0
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
        let g:deoplete#enable_at_startup=1
    Plug 'Shougo/neosnippet'
        inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
            \(neosnippet#expandable_or_jumpable() ?
            \"\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
        inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
        imap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        xmap <C-k> <Plug>(neosnippet_expand_target)
    Plug 'Shougo/neosnippet-snippets'
    Plug 'Shougo/neopairs.vim'
        let g:neopairs#enable = 1
    Plug 'Shougo/deoplete-clangx', { 'for': ['c', 'cpp'] }
    Plug 'python-mode/python-mode', { 'for': ['python'] }
else
" coc {{{
    " 需要 nodejs 支持
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" }}}
endif
" }}}


" UI {{{
if count(g:zl_plugins, 'colorscheme')
    "Plug 'lifepillar/vim-solarized8'
    Plug 'tomasiser/vim-code-dark'
endif
if count(g:zl_plugins, 'powerline')
    "Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'
    "Plug 'liuchengxu/eleline.vim'
    Plug 'itchyny/lightline.vim'
endif
" }}} UI

call plug#end()
" }}} load plugins

" config plugins {{{

" tabular
nnoremap <leader>== :Tabularize /=<CR>
vnoremap <leader>== :Tabularize /=<CR>
nnoremap <leader>=: :Tabularize /:\zs<CR>
vnoremap <leader>=: :Tabularize /:\zs<CR>
" 自动对齐 `|` 标识的表格
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" gutentags
let g:gutentags_project_root = ['.root', '.git', '.svn', '.project']
let g:gutentags_ctags_tagfile = '.tags'
if has('nvim')
    let g:gutentags_cache_dir = expand('~/.local/share/nvim/tags')
else
    let g:gutentags_cache_dir = expand('~/.vim/tmp/tags')
endif
if !isdirectory(g:gutentags_cache_dir)
    silent! call mkdir(g:gutentags_cache_dir, 'p')
endif
let g:gutentags_ctags_extra_args = ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--extra=+q']

" vista
"let g:vista_default_executive = 'coc'
noremap <silent><leader>v :Vista!!<cr>

"fzf
"noremap <C-p> :FZF
"noremap <C-f> :Mru
"noremap <M-p> :Mru

" nerdtree
let g:NERDTreeWinPos="left"
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeKeepTreeInNewTab=1
let g:NERDTreeIgnore=['\.o$', '\~$', '\.tags$']
" 打开/关闭NERDTree
map <leader>t :NERDTreeToggle<CR>
map <leader>nb :NERDTreeFromBookMark<CR>
" 定位当前文件
map <leader>nf :NERDTreeFind<CR>

" neomake
"if isdirectory(s:plug.'/neomake')
"    call neomake#configure#automake('nw', 750)
"endif

" coc
source ~/.config/nvim/vimrcs/coc.vim

" colorscheme {{{
if count(g:zl_plugins, 'colorscheme')
    set termguicolors
    "if filereadable(s:plug.'/vim-solarized8/colors/solarized8.vim')
    "    colorscheme solarized8
    "endif
    colorscheme codedark
endif
" }}}

" powerline {{{
if count(g:zl_plugins, 'powerline')
if 0
    "let g:airline_theme='solarized'
    let g:airline_theme='codedark'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline#extensions#tabline#show_tab_count = 0
    let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
    let g:airline#extensions#tabline#show_tab_type = 0
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#show_close_button = 0
else
    set noshowmode
    set showtabline=2

    let g:lightline = {
        \ 'colorscheme': 'codedark',
        \ 'mode_map': {
          \ 'n' : 'N',
          \ 'i' : 'I',
          \ 'R' : 'R',
          \ 'v' : 'V',
          \ 'V' : 'VL',
          \ "\<C-v>": 'VB',
          \ 'c' : 'C',
          \ 's' : 'S',
          \ 'S' : 'SL',
          \ "\<C-s>": 'SB',
          \ 't': 'T',
        \ },
        \ 'active': {
          \ 'left': [
            \ [ 'mode', 'paste' ],
            \ [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ],
          \ ],
          \ 'right': [
            \ [ 'lineinfo' ],
            \ [ 'percent' ],
            \ [ 'fileformat', 'fileencoding', 'filetype' ],
            \ [ 'blame' ]
          \ ]
        \ },
        \ 'component_function': {
          \ 'gitbranch': 'LightLineGitBranch',
          \ 'gitstatus': 'LightLineGitStatus',
          \ 'cocstatus': 'coc#status',
          \ 'blame': 'LightlineGitBlame'
        \ },
    \ }
    function! LightLineGitBranch() abort
        let status = get(g:, 'coc_git_status', '')
        return status
    endfunction
    function! LightLineGitStatus() abort
        let status = get(b:, 'coc_git_status', '')
        return status
    endfunction
    function! LightlineGitBlame() abort
        let blame = get(b:, 'coc_git_blame', '')
        " return blame
        return winwidth(0) > 120 ? blame : ''
    endfunction
    autocmd User CocStatusChange,CocDiagnosticChange,CocGitStatusChange call lightline#update()
endif
endif
" }}}

" }}} config plugins
