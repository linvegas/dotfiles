vim.cmd("hi clear")
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.g.colors_name = "twodark"

local hl = {}

local c = {
  Bg =        "#1D1D28",
  LightBg =   "#2b3139",
  LighterBg = "#363a48",
  Fg =        "#c0c9db",
  Gray =      "#535965",
  LightGray = "#868d9c",
  Blue =      "#57a5e5",
  Green =     "#98c379",
  Magenta =   "#bb70d2",
  Yellow =    "#d5c687",
  Cyan =      "#56b6c2",
  Orange =    "#bc8a5b",
  Red =       "#e86671",
}

hl.editor = {
  Normal =       { fg = c.Fg, bg = c.Bg },
  Visual =       { bg = c.LighterBg },
  StatusLine =   { fg = c.Fg, bg = c.LightBg },
  CursorLine =   { bg = c.LightBg },
  CursorLineNr = { fg = c.Fg, fmt = "bold"},
  LineNr =       { fg = c.Gray },
  VertSplit =    { fg = c.LightGray, bg = c.Bg },
  Pmenu =        { bg = c.Gray },
  PmenuSel =     { fg = c.Bg, bg = c.Blue },
  PmenuSbar =    { bg = c.Gray },
  PmenuThumb =   { bg = c.Fg },
  TabLine =      { fg = c.Gray, bg = c.Bg },
  TabLineSel =   { fg = c.Fg, bg = c.Gray },
  TabLineFill =  { fg = c.Gray, bg = c.Bg },
}

hl.syntax = {
  Comment =    { fg = c.Gray },
  Constant =   { fg = c.Orange },
  String =     { fg = c.Green },
  Character =  { fg = c.Orange },
  Number =     { fg = c.Orange },
  Boolean =    { fg = c.Orange },
  Float =      { fg = c.Orange },
  Identifier = { fg = c.Red},
  Function =   { fg = c.Blue},
  Statement =  { fg = c.Magenta, fmt = "bold" },
  Type =       { fg = c.Yellow,  fmt = "bold" },
  Special =    { fg = c.Red },
  Delimiter =  { fg = c.LightGray },
  Title =      { fg = c.Blue, fmt = "bold" },
}

hl.treesitter = {
  ["@field"] =            { fg = c.Cyan },
  ["@constructor"] =      { fg = c.Yellow },
  ["@variable"] =         { fg = c.Fg },
  ["@variable.builtin"] = { fg = c.Red },
  ["@include"] =          { fg = c.Magenta, fmt = "bold" },
  ["@type.builtin"] =     { fg = c.Orange },
  ["@property"] =         { fg = c.Cyan },
  ["@operator"] =         { fg = c.Fg },
  ["@tag"] =              { fg = c.Magenta },
  ["@tag.attribute"] =    { fg = c.Yellow, fmt = "bold" },
  ["@text.strong"] =      { fg = c.Fg, fmt = "bold" },
  ["@text.emphasis"] =    { fg = c.Fg, fmt = "italic" },
  ["@text.underline"] =   { fg = c.Fg, fmt = 'underline' },
  ["@text.strike"] =      { fg = c.Fg, fmt = 'strikethrough' },
}

local function set_highlights(groups)
  for group_name, group_opts in pairs(groups) do
    vim.api.nvim_command(string.format(
      "highlight %s guifg=%s guibg=%s gui=%s", group_name,
      group_opts.fg or "none", group_opts.bg or "none", group_opts.fmt or "none"
    ))
  end
end

set_highlights(hl.editor)
set_highlights(hl.syntax)
set_highlights(hl.treesitter)
