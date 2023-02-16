local opts = { noremap = true }
local keymap = vim.keymap.set

-- Spacebar as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Newtab prompt
keymap("n", "<leader>n", ":tabnew<space>", opts)

-- Open terminal on split and buffer
keymap("n", "<leader>t", ":vsplit term://zsh<CR>", opts)
keymap("n", "<leader>T", ":split term://zsh<CR>", opts)
keymap("n", "<leader>tt", ":e term://zsh<CR>", opts)

-- Buffer and tab switch
keymap("n", "<C-S-h>", ":bp<CR>", opts)
keymap("n", "<C-S-l>", ":bn<CR>", opts)
keymap("n", "<C-h>", ":tabprevious<CR>", opts)
keymap("n", "<C-l>", ":tabnext<CR>", opts)

-- Yank line
keymap("n", "Y", "yy", opts)

-- Open vim File Browser
keymap("n", "<F3>", ":Explore<CR>", opts)
keymap("n", "<F4>", ":Rexplore<CR>", opts)

-- A and I insert mode shortcut
keymap("i", "<C-a>", "<esc>A", opts)
keymap("i", "<C-i>", "<esc>I", opts)

-- New line in insert mode
keymap("i", "<C-o>", "<esc>o", opts)
keymap("i", "<C-S-o>", "<esc>O", opts)

-- Replace selected text in visual mode and prompt for each substitution
-- Press 'a' to confirm all or 'q' to quit
keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', opts)

-- Move selected text between lines
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Esc to enter normal mode while on terminal
keymap("t", "<ESC>", "<C-\\><C-n>", opts)
