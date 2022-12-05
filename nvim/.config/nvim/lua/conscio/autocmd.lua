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

-- Put a shebang on every new shell script buffer
au("BufNewFile", {
  group = ag("Shebang", { clear = true }),
  pattern = "*.sh",
  command = '0put =\\"#!/usr/bin/env sh\\<nl>\\<nl>\\"|$'
})

-- Compile tex file on save
au("BufWritePost", {
  group = ag("Latex", { clear = true }),
  pattern = "*.tex",
  command = "silent !comptex % > /dev/null"
})
