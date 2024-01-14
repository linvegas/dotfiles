local keymap = vim.keymap.set

-- Mapping leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Yank the whole line
keymap("n", "Y", "yy", { noremap = true })

-- Hide/show the statusline
keymap("n", "<leader>b", ":set laststatus=0<CR>", { noremap = true, silent = true })
keymap("n", "<leader>B", ":set laststatus=3<CR>", { noremap = true, silent = true })

-- Quickfix shortcuts
keymap("n", "<leader>co", ":copen<CR>", { noremap = true })
keymap("n", "<leader>cn", ":cnext<CR>", { noremap = true })
keymap("n", "<leader>cp", ":cprevious<CR>", { noremap = true })
keymap("n", "<leader>cc", ":cclose<CR>", { noremap = true })

-- Open a terminal on vertical or horizontal split
keymap("n", "<leader>T", ":vsplit term://zsh<CR>", { noremap = true })
keymap("n", "<leader>t", ":split term://zsh<CR>", { noremap = true })

-- Open netrw
keymap("n", "<F3>", ":Ex<CR>", { noremap = true })

-- Move selected block up or down
keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- Select a word and type <C-r> in visual mode to replace every instace
-- of it with a provided input, aka automated substitute command
keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true })

-- Exit terminal mode with C-x
keymap("t", "<C-x>", "<C-\\><C-n>", { noremap = true })
