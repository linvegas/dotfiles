-- General options
local opt = vim.opt

local options = {
	number = true,
	relativenumber = true,
  cursorline = true,
	tabstop = 2,
	shiftwidth = 2,
  scrolloff = 8,
	splitbelow = true,
	splitright = true,
	expandtab = true,
	wrap = false,
	clipboard = "unnamedplus"
}

for k, v in pairs(options) do
	opt[k] = v
end

