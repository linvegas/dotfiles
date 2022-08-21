"" Some basics
set number
set scrolloff=8
set cursorline
set splitbelow splitright
set tabstop=2 shiftwidth=2
set expandtab
set nowrap
set makeprg=gcc\ -Wall\ %\ -o\ %<

"" Bloody plugins
runtime ./plug.vim

"" Mapping stuff
runtime ./maps.vim

"" Vimwiki
let g:vimwiki_list = [{'path': '~/docx/vimwiki/', 'path_html': '~/docx/vimwiki-html'}]

"" Some commands
" Delete unecessary whitespaces
autocmd BufWritePre * %s/\s\+$//e

" Remember last cursor position, basically the commmand 'g;'
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Put a shebang on every new shell script buffer
augroup Shebang
  autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env sh\<nl>\<nl>\"|$
augroup END
