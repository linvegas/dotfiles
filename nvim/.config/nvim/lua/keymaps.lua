-- Leader key <SPACE>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Yank the whole line
vim.keymap.set("n", "Y", "yy", { noremap = true })

-- Hide/show the statusline
vim.keymap.set("n", "<leader>h", ":set laststatus=0<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>H", ":set laststatus=3<CR>", { noremap = true, silent = true })

-- Quickfix shortcuts
vim.keymap.set("n", "<leader>co", ":copen<CR>", { noremap = true })
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { noremap = true })
vim.keymap.set("n", "<leader>cp", ":cprevious<CR>", { noremap = true })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { noremap = true })

-- Open a terminal on vertical or horizontal split
vim.keymap.set("n", "<leader>T", ":vsplit term://zsh<CR>", { noremap = true })
vim.keymap.set("n", "<leader>t", ":split term://zsh<CR>", { noremap = true })

-- Open netrw/oil
vim.keymap.set("n", "<F2>", ":Oil<CR>", { noremap = true })
vim.keymap.set("n", "<leader>O", ":Oil<CR>", { noremap = true })

-- Buffer command command shortcut
vim.keymap.set("n", "<C-b>", ":Buffer <C-Z>", { noremap = true })
vim.keymap.set("n", "<leader>b", ":b <C-Z>", { noremap = true })

-- Move selected block up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- Select a word and type <C-r> in visual mode to replace every instace
-- of it with a provided input, aka automated substitute command
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { noremap = true })

-- Exit terminal mode with C-x
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { noremap = true })

