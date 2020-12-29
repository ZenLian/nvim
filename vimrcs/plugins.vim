" vim: set shiftwidth=2 ft=vim foldmethod=marker foldmarker={{{,}}} foldlevel=99 :

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
endif
    Plug 'liuchengxu/vista.vim'
    " yank历史
    Plug 'junegunn/vim-peekaboo'
" }}}

" 用 coc-list 代替
" fuzzy find {{{
    "Plug 'Yggdroot/LeaderF'
"Plug 'Shougo/denite.nvim' " 功能强大，配置复杂
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
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

" auto complete {{{
    " coc, 需要 nodejs 支持
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
" }}}

" debug {{{
    let g:vimspector_enable_mappings = 'HUMAN'
    Plug 'puremourning/vimspector', {'for': ['c', 'cpp']}
" }}}

" language specific {{{
" use coc
"Plug 'python-mode/python-mode', { 'for': ['python'] }
Plug 'plasticboy/vim-markdown', {'for':['markdown']}
" }}}

" UI {{{
Plug 'mhinz/vim-startify'
if count(g:zl_plugins, 'colorscheme')
    Plug 'tomasiser/vim-code-dark'
    Plug 'lifepillar/vim-solarized8'
    Plug 'itchyny/landscape.vim'
    Plug 'sainnhe/sonokai'
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

" vim-sneak {{{
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
let g:sneak#use_ic_scs = 1
let g:sneak#prompt = 'sneak> '
"}}}

" tabular {{{
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
" }}}

" gutentags {{{
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
" }}}

" vista {{{
let g:vista_default_executive = 'coc'
let g:vista_executive_for = {
    \ 'vimwiki': 'markdown',
    \ 'pandoc': 'markdown',
    \ 'markdown': 'toc',
    \ }
noremap <silent><leader>v :Vista!!<cr>
" }}}

" vim-clap {{{
let g:clap_theme = 'material_design_dark'
noremap <silent><leader>pp :Clap providers<cr>
noremap <silent><leader>pf :Clap files<cr>
noremap <silent><leader>ph :Clap history<cr>
noremap <silent><leader>pb :Clap buffers<cr>
noremap <silent><leader>py :Clap yanks<cr>
noremap <silent><leader>pc :Clap hist:<cr>
noremap <silent><leader>pl :Clap lines<cr>
let g:clap_layout = { 'relative': 'editor' }
" }}}

" vim-markdown
let g:vim_markdown_folding_style_pythonic = 1

" coc
source ~/.config/nvim/vimrcs/coc.vim

" vim-startify {{{
    autocmd User Startified setlocal cursorline
" }}}

" colorscheme {{{
if count(g:zl_plugins, 'colorscheme')
    set termguicolors
    colorscheme solarized8_flat
endif
" }}}

" powerline {{{
if count(g:zl_plugins, 'powerline')
    set noshowmode
    set showtabline=2

    let g:lightline = {
        \ 'colorscheme': 'solarized8',
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
" }}}

" }}} config plugins
