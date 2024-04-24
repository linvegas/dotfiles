local opt = vim.opt

-- vim.cmd("colorscheme muhdark")

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.laststatus = 3
opt.splitbelow = true
opt.splitright = true

opt.tabstop     = 4
opt.softtabstop = 4
opt.shiftwidth  = 4
opt.smartindent = true
opt.expandtab   = true

opt.hlsearch = false
opt.scrolloff = 8
opt.wrap = false

opt.fillchars = { eob = " " }
opt.listchars = "tab:» ,trail:•,extends:>,leadmultispace:•···"
opt.list = true

opt.title = true
opt.titlestring = "%t%(%M%)"

opt.pumheight = 10
opt.completeopt = "menuone,noinsert,noselect"
opt.wildoptions = "fuzzy,pum"

opt.shortmess:append({c = true, W = true})
opt.showmode = false

opt.cmdheight = 1

for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end
