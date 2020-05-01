let g:coc_global_extensions = [
    \ 'coc-emmet', 'coc-highlight', 'coc-lists', 'coc-pairs', 'coc-snippets', 'coc-yank', 'coc-git',
    \ 'coc-dictionary', 'coc-syntax',
    \ 'coc-json', 'coc-vimlsp'
    \ ]

" vimlsp
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
      "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  "inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  inoremap <silent><expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fm <Plug>(coc-format-selected)
nmap <leader>fm <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
"nmap <silent> <Tab> <Plug>(coc-range-select)
"xmap <silent> <Tab> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>le  :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>lc  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>lb  :<C-u>CocList buffers<cr>
" Find symbol of current document.
nnoremap <silent> <leader>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <leader>ll  :<C-u>CocListResume<CR>

" coc-yank
nnoremap <silent> <leader>ly  :<C-u>CocList -A yank<cr>
" coc-files
nnoremap <silent> <C-p>  :<C-u>CocList -A files<cr>
nnoremap <silent> <leader>lm  :<C-u>CocList -A mru<cr>
"
" coc-grep
"
" grep any
nnoremap <silent> <C-f>  :<C-u>CocList grep<cr>
" grep from selected globally
vnoremap <C-f>  :<C-u>call <SID>GrepFromSelected(visualmode(), 'global')<CR>
" search current word in current buffer
nnoremap <silent> -  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
vnoremap <silent> - :<C-u>call <SID>GrepFromSelected(visualmode(), 'buffer')<CR>
"nnoremap <leader>- :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
" grep in current buffer
nnoremap <leader>- :<C-u>CocList lines<CR>

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>
function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

function! s:GrepFromSelected(type, range)
  if a:type ==# 'v'
    let saved_unnamed_register = @@
    normal! `<v`>y
    let word = substitute(@@, '\n$', '', 'g')
    let word = escape(word, '| ')
    let @@ = saved_unnamed_register
  elseif a:type ==# 'char'
    let word = expand('<cword>')
  "  normal! `[v`]y
  else
    return
  endif
  if a:range ==# 'global'
      execute 'CocList grep -F -S '.word
  elseif a:range ==# 'buffer'
      execute 'CocList -I --normal --input='.word.' words'
  else
      return
  endif
endfunction

" coc-git {{{
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nnoremap <silent> <leader>lg :<C-u>CocList gstatus<CR>
" }}}

" coc-snippets {{{
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
"vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
"imap <C-j> <Plug>(coc-snippets-expand-jump)
" }}} coc-snippets
