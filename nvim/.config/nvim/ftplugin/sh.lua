vim.keymap.set( "n", "<leader>r", ":split term://bash %<CR>", { remap = true, buffer = true, silent = true })
vim.keymap.set( "n", "<leader>R", ":split term://bash -x %<CR>", { remap = true, buffer = true, silent = true })
