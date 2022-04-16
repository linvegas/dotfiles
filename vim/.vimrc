" Basics
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline

" Editing
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

" Menu
set splitbelow splitright
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Plugins
call plug#begin('~/.vim/plugged')



call plug#end()

" Keybind


" Vimscript
colorscheme onedark

" Status Line

highlight fileType term=bold ctermfg=235 ctermbg=114 guifg=#282C34 guibg=#98C379    
highlight fileLine term=reverse ctermfg=180 ctermbg=59 guifg=#E5C07B guibg=#5C6370

set laststatus=2
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %#fileType#
set statusline+=\ %Y
set statusline+=\ %#fileLine#
set statusline+=\ %l:%c
set statusline+=\ %P

