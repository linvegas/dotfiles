local keymap = vim.keymap.set
local opts = { noremap = true }

-- Mapping leader to <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Yank whole line
keymap("n", "Y", "yy", opts)

-- Open the explorer plugin
keymap("n", "<F3>", ":Explore<CR>", opts)
keymap("n", "<F4>", ":Rexplore<CR>", opts)

-- Navigating between tabs and buffers
keymap("n", "<C-h>", ":bp<CR>", opts)
keymap("n", "<C-l>", ":bn<CR>", opts)
keymap("n", "<C-S-h>", ":tabprevious<CR>", opts)
keymap("n", "<C-S-l>", ":tabnext<CR>", opts)

-- Open a terminal on vertical or horizontal split
keymap("n", "<leader>t", ":vsplit term://zsh<CR>", opts)
keymap("n", "<leader>T", ":split term://zsh<CR>", opts)

-- Hide/show the statusline
keymap("n", "<leader>b", ":set laststatus=0<CR>", { silent = true })
keymap("n", "<leader>B", ":set laststatus=3<CR>", { silent = true })

-- Run last command
keymap("n", "<leader>:", ":@:<CR>", { silent = true })

-- Quickfix shortcuts
keymap("n", "<leader>co", ":copen<CR>", opts)
keymap("n", "<leader>cn", ":cnext<CR>", opts)
keymap("n", "<leader>cp", ":cprevious<CR>", opts)

-- Enter a new line in insert mode whitout breaking the line
keymap("i", "<C-o>", "<esc>o", opts)
keymap("i", "<C-S-o>", "<esc>O", opts)

-- Move selected block text to anywhere
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Select a word and type <C-r> in visual mode to replace every instace of it
-- with a provided input, aka, automated substitute command
keymap("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', opts)

-- Exit terminal mode hitting <C-x>
keymap("t", "<C-x>", "<C-\\><C-n>", opts)

-- Telescope
keymap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
keymap('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>ft', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>fs', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

