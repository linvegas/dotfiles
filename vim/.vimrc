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
set nobackup
set t_Co=256
set background=dark

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
set autoindent
set smartindent
set splitbelow splitright

""""""""""""""
"    Menu    "
""""""""""""""
set path+=**
set wildmenu
"set wildmode=longest:full,full
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

"""""""""""""""""""""
"    File Browse    "
"""""""""""""""""""""

let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3

"""""""""""""""""
"    Plugins    "
"""""""""""""""""
call plug#begin('~/.vim/plugged')

  Plug 'mattn/emmet-vim'
  Plug 'joshdick/onedark.vim'
  Plug 'itchyny/lightline.vim'
  "Plug 'SirVer/ultisnips'

call plug#end()

"colorscheme gruvbox
colorscheme onedark
"highlight Normal ctermbg=Black
"highlight NonText ctermbg=Black

"""""""""""""""""
"    Keybind    "
"""""""""""""""""

" Buffer Switching
nnoremap <C-j> :bp<CR>
nnoremap <C-k> :bn<CR>

" Autocomplete
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Emmet plugin
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Ultil Snips
"let g:UltiSnipsExpandTrigger="<c-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"""""""""""""""""""
"    Vimscript    "
"""""""""""""""""""

" Remember last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Deletes all white spaces on save
autocmd BufWritePre * %s/\s\+$//e

"""""""""""""""""""""
"    Status Line    "
"""""""""""""""""""""

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

"function! StatuslineMode() abort
"  let l:currentmode = {
"    \ 'n': 'NOMRAL',
"    \ 'v': 'VISUAL',
"    \ 'V': 'V-LINE',
"    \ '^V': 'V-BLOCK',
"    \ 's':  'SUBST.',
"    \ 'S': 'S-LINE',
"    \ '^S': 'S-BLOCK',
"    \ 'i': 'INSERT',
"    \ 'R': 'REPLACE',
"    \ 'c': 'COMMAND',
"    \ 't':  'TERMINAL'}
"
"  let l:modecurrent = mode()
"  let l:modelist = toupper(get(l:currentmode, l:modecurrent, 'VB'))
"  let l:current_status_mode = l:modelist
"  return l:current_status_mode
"endfunction
"
"highlight fileType term=bold ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379
"highlight fileLine term=reverse ctermfg=180 ctermbg=59 guifg=#E5C07B guibg=#5C6370
"highlight viMode ctermfg=15 ctermbg=242 gui=bold guifg=White guibg=Grey40
"highlight Conceal term=standout
"
"set statusline+=\ %#viMode#
"set statusline+=\ %{StatuslineMode()}
"set statusline+=\ %#Conceal#
"set statusline+=\ %f
"set statusline+=%=
"set statusline+=\ %#fileType#
"set statusline+=\ %Y
"set statusline+=\ %#fileLine#
"set statusline+=\ %l:%c
"set statusline+=\ %P

