local options = {
  defaults = {
    file_ignore_patterns = {
      "node_modules", "venv",
      "%.png", "%.jpg", "%.gif", "%.jpeg"
    },
    mappings = {
      i = { ["<ESC>"] = require("telescope.actions").close },
    },
  },
  pickers = {
    find_files = {
      follow = true
    },
    buffers = {
      sort_lastused = true
    },
  }
  -- extensions_list = { "fzf" },
}

return options
