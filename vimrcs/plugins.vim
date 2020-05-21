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
    Plug 'liuchengxu/vista.vim'
endif
    " yank历史
    Plug 'junegunn/vim-peekaboo'
" }}}

" defx {{{
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" }}}

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

" auto complete {{{
    " coc, 需要 nodejs 支持
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
" }}}


" language specific {{{
"Plug 'python-mode/python-mode', { 'for': ['python'] }
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

" defx {{{
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'botright',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1,
      \ 'columns': 'mark:indent:icon:filename:type:size:time',
      \ })

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

call defx#custom#column('mark', {
      \ 'readonly_icon': '✗',
      \ 'selected_icon': '✓',
      \ })

nnoremap <silent> <F3> :Defx<cr>
nnoremap <silent> <leader>e :Defx `expand('%:p:h')` -search=`expand('%:p')`<cr>

autocmd FileType defx call s:defx_keymaps()
function! s:defx_keymaps() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open_directory') :
  \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> t
  \ defx#do_action('multi', [['open', 'tab drop'], 'quit'])
  nnoremap <silent><buffer><expr> v
  \ defx#do_action('multi', [['open', 'vsplit'], 'quit'])
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> l
  \ defx#is_directory() ?
  \ defx#do_action('open_directory') :
  \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> o
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree')
  \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Bslash>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>
  \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> < defx#do_action('resize',
  \ defx#get_context().winwidth + 10)
  nnoremap <silent><buffer><expr> > defx#do_action('resize',
  \ defx#get_context().winwidth - 10)
endfunction
" }}}

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
" }}}

" }}} config plugins
