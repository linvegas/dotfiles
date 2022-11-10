" Spacebar as leader key
let mapleader = "\<space>"

" Vertical split init.vim
nmap <leader>rc :vsp $MYVIMRC<CR>
" New tab prompt
nmap <leader>n :tabnew<Space>
" Open current file on browser
nmap <leader>W !firefox -private-window %<CR>

" Buffer and tab switch
nnoremap <C-S-h> :bp<CR>
nnoremap <C-S-l> :bn<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Yank line
nnoremap Y yy

" A and I insert mode shortcut
inoremap <C-a> <esc>A
inoremap <C-i> <esc>I

" New line in insert mode
inoremap <C-o> <esc>o
inoremap <C-S-o> <esc>O

" Replace selected text in visual mode and prompt for each substitution
" Press 'a' to confirm all or 'q' to quit
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
