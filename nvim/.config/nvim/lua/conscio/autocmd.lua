-- Auto commands
local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Delete whitespaces on save
au('BufWritePre', {
  group = ag("cleanWhitespaces", { clear = true }),
  pattern = "*",
  command = ":%s/\\s\\+$//e"
})

-- Remember last position
au("BufReadPost", {
  group = ag("Remember", { clear = true }),
  pattern = "*",
  callback = function()
    local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = vim.api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      vim.api.nvim_win_set_cursor(0, { row, column })
    end
  end,
})

-- Compile tex file on save
au("BufWritePost", {
  group = ag("Latex", { clear = true }),
  pattern = "*.tex",
  command = "silent !comptex % > /dev/null"
})

-- Enter insertmode and remove numberline on every terminal
au("TermOpen", {
  group = ag("Term", { clear = true }),
  pattern = "*",
  command = "setlocal nonumber norelativenumber | startinsert"
})

-- Template for especific filetypes
au("BufNewFile", {
  group = ag("Template", { clear = true }),
  pattern = { "*.sh", "*.c", "*.html"},
  command = "0r $HOME/.config/nvim/templates/skeleton.%:e"
})

