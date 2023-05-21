local options = {
  defaults = {
    file_ignore_patterns = {
      "node_modules" ,
      "%.png", "%.jpg", "%.gif", "%.jpeg"
    },
    mappings = {
      i = { ["<ESC>"] = require("telescope.actions").close },
    },
  },
  pickers = {
    find_files = {
      follow = true
    }
  }
  -- extensions_list = { "fzf" },
}

return options
