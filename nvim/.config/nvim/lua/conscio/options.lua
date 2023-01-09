-- General options
local opt = vim.opt

local options = {
	number = true,
	relativenumber = true,
  cursorline = true,
	tabstop = 2,
	shiftwidth = 2,
  softtabstop = 2,
	expandtab = true,
  scrolloff = 8,
	splitbelow = true,
	splitright = true,
	wrap = false,
	clipboard = "unnamedplus",
  hlsearch = false,
  incsearch = true,
  termguicolors = true
}

for k, v in pairs(options) do
	opt[k] = v
end

