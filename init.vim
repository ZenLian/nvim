" termtype
"   'screen' : GUI or SCREEN
"   'xterm' : TERMINAL
let g:zl_termtype='xterm'
let g:zl_plugins=['basics', 'colorscheme', 'powerline']
"let g:zl_plugins=['basics']

" source local config, take python-virtualenv as an example
"let g:python3_host_prog = expand('~/anaconda3/envs/py3-nvim/bin/python')
"let g:python_host_prog = expand('~/anaconda3/envs/py2-nvim/bin/python')
if filereadable(expand('~/.config/nvim/vimrcs/local.vim'))
    source ~/.config/nvim/vimrcs/local.vim
endif

source ~/.config/nvim/vimrcs/1.plugins.vim
source ~/.config/nvim/vimrcs/2.general.vim
source ~/.config/nvim/vimrcs/3.keymappings.vim
source ~/.config/nvim/vimrcs/4.ui.vim

