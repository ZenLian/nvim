" vim: set foldmethod=marker foldmarker={{{,}}} foldlevel=0 :

" 背景色反转
function! ToggleBG()
    let s:tbg = &background
    if  s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <leader>bg :call ToggleBG()<CR>

" 编辑/重载vimrc配置
map <leader>rc :edit $MYVIMRC<cr>
map <leader>sc :source $MYVIMRC<cr>

" 快速保存
nmap <leader>w :w!<cr>
" 快速退出
nmap Q :q<cr>
" 以root权限保存
command! W w !sudo tee % >/dev/null

" 关闭高亮
map <silent><leader><enter> :noh<cr>

" Y从当前位置复制到行尾, 与D, C一致
nnoremap Y y$
" visual 模式下 Y 复制到系统剪切板
vnoremap Y "+y
" 屏幕左右移动
nnoremap zh zH
nnoremap zl zL
" 上下移动
nnoremap <C-y> 5<C-y>
nnoremap <C-e> 5<C-e>

" Visual模式缩进不退出
vnoremap < <gv
vnoremap > >gv

" Visual模式上下移动多行
vnoremap J 5j
vnoremap K 5k

" Visual模式能使用repeat
vnoremap . :normal .<CR>

" 使用ALT+[jk]上下移动当前行 {{{
" FIXME: vim终端下无效
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" }}}

" 使用Ctrl+h/j/k/l在窗口间移动 {{{
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" }}}

" 操作tab页快捷键 {{{

"nmap <TAB>n :tabnew<cr>
"nmap <TAB>o :tabonly<cr>
"nmap <TAB>c :tabclose<cr>
"nmap <TAB>m :tabmove<space>
" 切换tab页
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <leader>0 10gt
" 上一个/下一个tab
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>
" 返回上一次的tab
let g:lasttab = 1
nmap <leader><Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" }}}

" 操作buffer快捷键 {{{

" 列出所有buffer
nnoremap <leader>bb :buffers<cr>
" 关闭当前buffer
map <leader>bd :bd<cr>
" 下一个/上一个buffer
nnoremap ]b :bnext!<cr>
nnoremap [b :bprevious!<cr>

" }}}

" 进入当前文件目录
" "cmap cwd lcd %:p:h
" "cmap cd. lcd %:p:h

" TODO: z+数字查看man手册页
" source $VIMRUNTIME/ftplugin/man.vim
"nmap m1 :Man 1 =expand("")
"nmap m2 :Man 2 =expand("")

" Bash风格快捷键 {{{
" go to the beginning/end
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
" go back/forward one word
"cnoremap <M-B>
"cnoremap <M-F>
" go back/forward one character
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
inoremap <C-B> <Left>
inoremap <C-F> <Right>
" cut till the beginning/end
"cnoremap <C-U>
"cnoremap <C-K>
cnoremap <C-H> <Backspace>
cnoremap <C-D> <Del>

" Dealing remap collisions
" show command history
"cnoremap <C-L> <C-F>
" List command completion
"cnoremap <C-O> <C-D>

" }}}

" 拼写检查 {{{
" 开关拼写检查
" map <leader>ss :setlocal spell!<cr>
" 下/上一处拼写错误
"map <leader>sn ]s
"map <leader>sp [s
" 添加至词典
"map <leader>sa zg
" 显示拼写建议
"map <leader>s? z=
" }}}

