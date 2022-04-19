""""""""""""""""
"    Basics    "
"""""""""""""""" 
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline

"""""""""""""""
"   Editing   "
"""""""""""""""
set shiftwidth=2
set tabstop=2
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set smartcase
set showmatch
set hlsearch
set history=1000

""""""""""""""
"    Menu    "
""""""""""""""
set splitbelow splitright
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

"""""""""""""""""
"    Plugins    "
"""""""""""""""""
call plug#begin('~/.vim/plugged')



call plug#end()

"""""""""""""""""
"    Keybind    "
"""""""""""""""""
"autocmd! BufWritePost .vimrc source %

" Buffer Switching
nnoremap <C-j> :bp<CR>
nnoremap <C-k> :bn<CR>

" Autocomplete
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

"""""""""""""""""""
"    Vimscript    "
"""""""""""""""""""
colorscheme onedark

"""""""""""""""""""""
"    Status Line    "
"""""""""""""""""""""

function! StatuslineMode() abort
  let l:currentmode = {
    \ 'n': 'NOMRAL',
    \ 'v': 'VISUAL',
    \ 'V': 'V-LINE',
    \ '^V': 'V-BLOCK',
    \ 's':  'SUBST.',
    \ 'S': 'S-LINE',
    \ '^S': 'S-BLOCK',
    \ 'i': 'INSERT',
    \ 'R': 'REPLACE',
    \ 'c': 'COMMAND',
    \ 't':  'TERMINAL'}

  let l:modecurrent = mode()
  let l:modelist = toupper(get(l:currentmode, l:modecurrent, 'VB'))
  let l:current_status_mode = l:modelist
  return l:current_status_mode
endfunction

highlight fileType term=bold ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379    
highlight fileLine term=reverse ctermfg=180 ctermbg=59 guifg=#E5C07B guibg=#5C6370
highlight viMode ctermfg=15 ctermbg=242 gui=bold guifg=White guibg=Grey40
highlight Conceal term=standout 

set laststatus=2
set statusline+=\ %#viMode#
set statusline+=\ %{StatuslineMode()} 
set statusline+=\ %#Conceal#
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %#fileType#
set statusline+=\ %Y
set statusline+=\ %#fileLine#
set statusline+=\ %l:%c
set statusline+=\ %P

