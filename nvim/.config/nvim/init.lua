require("options")
require("keymaps")
require("commands")
require("statusline")
require("lsp")
-- require("treesitter")

-- Manually install treesitter
local treesitter_path = vim.fn.stdpath("data") .. "/site/pack/nvim-treesitter/start/nvim-treesitter"
if not vim.loop.fs_stat(treesitter_path) then
    vim.notify("Installing treesitter plugin...", vim.log.levels.INFO)
    vim.fn.system({
        "git", "clone",
        "https://github.com/nvim-treesitter/nvim-treesitter",
        "--depth=1", treesitter_path,
    })
end

-- Stupid neovide config
if vim.g.neovide then
    vim.o.guifont = "mono:h14"
    vim.g.neovide_cursor_animation_length = 0

    vim.g.neovide_scale_factor = 1.0

    vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n" , "v" }, "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>")
    vim.keymap.set('v', '<C-c>', '"+y')
end
