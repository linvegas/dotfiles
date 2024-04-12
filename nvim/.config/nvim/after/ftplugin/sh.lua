vim.keymap.set( "n", "<leader>r", ":split term://sh %<CR>", { remap = true, buffer = true, silent = true })
vim.keymap.set( "n", "<leader>R", ":split term://sh -x %<CR>", { remap = true, buffer = true, silent = true })
vim.keymap.set( "n", "<leader>c", ":!shellcheck %<CR>", { remap = true, buffer = true, silent = true })
