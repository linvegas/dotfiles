local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

-- Deletes trailling whitespace on every save
autocmd('BufWritePre', {
	group = augroup("WhitespacesCleaner", { clear = true }),
	pattern = "*",
	command = ":%s/\\s\\+$//e"
})

-- Remeber cursor last position
autocmd("BufReadPost", {
  group = augroup("Remember", { clear = true }),
  pattern = "*",
  callback = function()
    local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
    local buf_line_count = vim.api.nvim_buf_line_count(0)

    if row >= 1 and row <= buf_line_count then
      vim.api.nvim_win_set_cursor(0, { row, column })
    end
  end,
})

-- Removes line number from terminal mode
autocmd("TermOpen", {
  group = augroup("TermBuffer", { clear = true }),
  pattern = "*",
  command = "setlocal nonumber norelativenumber | startinsert"
})

-- Load a boilerplate code for specific new files
autocmd("BufNewFile", {
  group = augroup("Template", { clear = true }),
  pattern = { "*.sh", "*.c", "*.html"},
  command = "0r $HOME/.config/nvim/templates/template.%:e"
})

-- Highlight yanked text
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

-- User command for loading personal templates
usercmd("LoadTemp", function(args)
  local path = vim.fn.stdpath "config" .. "/templates"
  local template_file =  path .. "/" .. args['args']
  local content = vim.fn.readfile(template_file)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_set_lines(0, cursor_pos[1] - 1, cursor_pos[1] - 1, false, content)
end, { nargs = 1 })
