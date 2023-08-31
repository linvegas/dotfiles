setlocal colorcolumn=80

if isdirectory("./venv")
  nnoremap <leader>r :split term://./venv/bin/python3 main.py<CR>
  nnoremap <leader>R :split term://./venv/bin/python3 %
elseif isdirectory("./.venv")
  nnoremap <leader>r :split term://./.venv/bin/python3 main.py<CR>
  nnoremap <leader>R :split term://./.venv/bin/python3 %
else
  nnoremap <leader>r :split term://python %<CR>
  nnoremap <leader>R :split term://python %
endif

