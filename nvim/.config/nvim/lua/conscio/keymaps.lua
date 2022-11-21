local opts = { noremap = true }

local keymap = vim.api.nvim_set_keymap

-- Spacebar as leader key
vim.g.mapleader = " "

-- Newtab prompt
keymap("n", "<leader>n", ":tabnew<space>", opts)

-- Buffer and tab switch
keymap("n", "<C-S-h>", ":bp<CR>", opts)
keymap("n", "<C-S-l>", ":bn<CR>", opts)
keymap("n", "<C-h>", ":tabprevious<CR>", opts)
keymap("n", "<C-l>", ":tabnext<CR>", opts)

-- Yank line
keymap("n", "Y", "yy", opts)

-- A and I insert mode shortcut
keymap("i", "<C-a>", "<esc>A", opts)
keymap("i", "<C-i>", "<esc>I", opts)

-- New line in insert mode
keymap("i", "<C-o>", "<esc>o", opts)
keymap("i", "<C-S-o>", "<esc>O", opts)

-- Replace selected text in visual mode and prompt for each substitution
-- Press 'a' to confirm all or 'q' to quit
keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', opts)

