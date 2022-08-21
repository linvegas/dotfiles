" Spacebar as leader key
let mapleader = "\<space>"

" Vertical split init.vim
nmap <leader>rc :vsp $MYVIMRC<CR>
" New tab prompt
nmap <leader>n :tabnew<Space>
" Open current file on browser
nmap <leader>W <cmd>!firefox -private-window %<CR>

" Buffer and tab switch
nnoremap <C-s>h :bp<CR>
nnoremap <C-s>l :bn<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Yank line
nnoremap Y yy

" A and I insert mode shortcut
inoremap <C-a> <esc>A
inoremap <C-i> <esc>I
