-- Numbers and line
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.cursorline = true

-- Window scroll
vim.opt.scrolloff = 8

-- Statusline
vim.opt.laststatus = 3

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Split window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Timings
vim.opt.timeoutlen = 500

-- Completition menu
vim.opt.pumheight = 10
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.wildmode = "longest:full,full"

-- Match and Search
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.clipboard = "unnamedplus"

-- Terminal title
vim.opt.title = true
vim.opt.titlestring = "%t%(%M%)"

-- Netrw config
vim.g.netrw_banner = 0

-- Disabling unecessary providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end
