vim.g.netrw_banner = 0
vim.g.netrw_list_hide = "^./$,^../$"

-- remap h: go back and l: enter a file or dir
vim.keymap.set("n", "l", "<CR>", { remap = true, buffer = true, silent = true })
vim.keymap.set("n", "h", "-",    { remap = true, buffer = true, silent = true })

-- remap n to enter a new file
vim.keymap.set("n", "n", "%",    { remap = true, buffer = true, silent = true })
