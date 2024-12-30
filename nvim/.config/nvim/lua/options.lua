vim.cmd("colorscheme penumbra")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.shiftwidth  = 4
vim.opt.softtabstop  = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.scrolloff = 4
vim.opt.wrap = false

vim.opt.fillchars = { eob = " " }
vim.opt.listchars = "tab:» ,trail:•,extends:>,precedes:<,leadmultispace:•···"
vim.opt.list = true

vim.opt.title = true
vim.opt.titlestring = "%t%(%M%)"

vim.opt.pumheight = 10
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.wildoptions = "fuzzy,pum"

vim.opt.shortmess:append({c = true, W = true})
vim.opt.showmode = false

-- vim.opt.cmdheight = 0

-- vim.opt.jumpoptions = "stack"

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end
