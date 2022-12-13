local status, telescope = pcall(require, "telescope")
if (not status) then return end

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fd", ":Telescope diagnostics<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "%.png", "%.jpg", "%.gif", "%.jpeg"
    },
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close
      }
    }
  },
  pickers = {
    find_files = {
      follow = true
    }
  }
}
