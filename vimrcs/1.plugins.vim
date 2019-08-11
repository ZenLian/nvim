" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=1 :

let mapleader = "\<Space>"

if has('nvim')
    call plug#begin('~/.local/share/nvim/plug')
else
    call plug#begin('~/.vim/bundle')
endif

" load plugins {{{

" 编辑辅助 {{{
    " basics
    Plug 'jiangmiao/auto-pairs'
        let g:AutoPairsShortcutToggle = '<M-a>'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    "Plug 'easymotion/vim-easymotion'

    " textobj {{{
    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'kana/vim-textobj-syntax'
    Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
    Plug 'sgur/vim-textobj-parameter'
    Plug 'bps/vim-textobj-python', {'for': 'python'}
    Plug 'jceb/vim-textobj-uri'
    " }}}
" }}}

" ctags {{{
if executable('ctags')
    set tags=./.tags;,.tags

    " vim-gutentags {{{
    if has('nvim') || v:version >= 800
        Plug 'ludovicchabant/vim-gutentags'
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
    endif
    " }}}

    " 性能不好，可以用fuzzy find插件替代
    " tagbar {{{
    Plug 'majutsushi/tagbar'
        map <F3> :TagbarToggle<CR>
        let g:tagbar_autofocus=1
    " }}}
endif
" }}}

" fuzzy find {{{
Plug 'Yggdroot/LeaderF'
    noremap <c-n> :LeaderfMru<CR>
    noremap <c-f> :LeaderfFunction<CR>
    noremap <m-p> :LeaderfTag<CR>
    noremap <m-m> :LeaderfBufTag<CR>
    let g:Lf_ShortcutF = '<C-P>'
    let g:Lf_ShortcutB = '<C-B>'
    if has('nvim')
        let g:Lf_CacheDirectory = expand('~/.local/share/nvim/cache')
    else
        let g:Lf_CacheDirectory = expand('~/.vim/tmp')
    endif
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    let g:Lf_StlColorscheme = 'powerline'
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', '.hg']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_ShowRelativePath = 0
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
    let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
            \}

"Plug 'Shougo/denite.nvim' " 功能强大，配置复杂
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'
" }}}

    " NERDTree {{{
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
        " NERDTree窗口显示在左边
        let g:NERDTreeWinPos="left"
        " 打开文件后关闭NERDTree
        let g:NERDTreeQuitOnOpen=1
        " 显示隐藏文件，I 切换
        let g:NERDTreeShowHidden=1
        let g:NERDTreeKeepTreeInNewTab=1
        let g:NERDTreeIgnore=['\.o$', '\~$', '\.tags$']
        " 打开/关闭NERDTree
        map <F2> :NERDTreeToggle<CR>
        map <leader>nb :NERDTreeFromBookMark<CR>
        " 定位当前文件
        map <leader>nf :NERDTreeFind<CR>
    "}}}

" 代码补全 {{{
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
" }}}

" 语法检查 {{{
    Plug 'neomake/neomake'
    "Plug 'w0rp/ale'
" }}}

" 代码格式化 {{{
    "Plug 'sbdchd/neoformat'
" }}}

" }}}

call plug#end()

" neomake
call neomake#configure#automake('nw', 750)

