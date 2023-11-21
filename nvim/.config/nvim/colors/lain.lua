vim.g.colors_name = "lain"
vim.cmd("hi clear")
vim.opt.background = "dark"
vim.opt.termguicolors = true

local hl = { plugins = {} }

local c = {
  Bg =        "#262224", -- purple-ish bg
  -- Bg =        "#191918", -- darker bg
  -- LightBg =   "#3D3842",
  LightBg =   "#2D282B",
  LighterBg = "#49394B",
  Fg =        "#FEFEFE",
  -- Fg =        "#EFECF1",
  Gray =      "#625669",
  LightGray = "#988EAD",
  -- LightGray = "#868d9c",

  Blue =      "#8FABE5",
  -- Blue =      "#7691CB",

  Green =     "#8EBE9C",
  -- Green =     "#90B270",

  Magenta =   "#9C8EBE",
  -- Magenta =   "#9F95B7",
  -- Magenta =   "#9E91D4",

  -- Yellow =    "#B4CA82",
  -- Yellow =    "#B9D775",
  -- Yellow =    "#CFDC98",
  Yellow =    "#CAD4A1",


  Cyan =      "#76BBCB",
  Orange =    "#BEB48E",
  Red =       "#BE8E98",
}

hl.editor = {
  Normal =       { fg = c.Fg, bg = c.Bg },
  Visual =       { bg = c.LighterBg },
  Terminal =     { fg = c.fg, bg = c.Bg},
  FoldColumn =   { fg = c.fg, c.LighterBg },
  Folded =       { fg = c.fg, c.LighterBg },
  StatusLine =   { fg = c.Fg, bg = c.LighterBg },
  ColorColumn =  { bg = c.LightBg },
  CursorLine =   { bg = c.LightBg },
  CursorLineNr = { fg = c.Fg, fmt = "bold"},
  Cursor =       { fmt = "reverse" },
  vCursor =      { fmt = "reverse" },
  iCursor =      { fmt = "reverse" },
  lCursor =      { fmt = "reverse" },
  CursorIM =     { fmt = "reverse" },
  LineNr =       { fg = c.Gray },
  VertSplit =    { fg = c.LightGray, bg = c.Bg },
  Pmenu =        { bg = c.Gray },
  PmenuSel =     { fg = c.Bg, bg = c.Magenta },
  PmenuSbar =    { bg = c.Gray },
  PmenuThumb =   { bg = c.Fg },
  TabLine =      { fg = c.Gray, bg = c.Bg },
  TabLineSel =   { fg = c.Fg, bg = c.Gray },
  TabLineFill =  { fg = c.Gray, bg = c.Bg },
  EndOfBuffer =  { fg = c.Gray },
  Substitute =   { fg = c.Bg, bg = c.Yellow },
  MatchParen =   { bg = c.Gray },
  ErrorMsg =     { fg = c.Red, fmt = "bold" },
  WarningMsg =   { fg = c.Yellow, fmt = "bold" },
  NormalFloat =  { fg = c.Fg, bg = c.LighterBg },
  FloatBorder =  { fg = c.Gray, bg = c.LighterBg },
  Directory =    { fg = c.Blue, fmt = "bold" },
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
  PreProc =    { fg = c.Magenta, fmt = "bold" },
  Type =       { fg = c.Yellow,  fmt = "bold" },
  Special =    { fg = c.Red },
  Delimiter =  { fg = c.LightGray },
  Title =      { fg = c.Blue, fmt = "bold" },
}

hl.treesitter = {
  ["@attribute"] =        { fg = c.LightGray },
  ["@field"] =            { fg = c.Red },
  ["@constructor"] =      { fg = c.Yellow },
  ["@variable"] =         { fg = c.Fg },
  ["@variable.builtin"] = { fg = c.Red },
  ["@include"] =          { fg = c.Magenta, fmt = "bold" },
  ["@type.builtin"] =     { fg = c.Yellow, fmt = "bold" },
  ["@property"] =         { fg = c.Cyan },
  ["@operator"] =         { fg = c.Fg },
  ["@tag"] =              { fg = c.Magenta },
  ["@tag.attribute"] =    { fg = c.Yellow, fmt = "bold" },
  ["@text.strong"] =      { fg = c.Fg, fmt = "bold" },
  ["@text.emphasis"] =    { fg = c.Fg, fmt = "italic" },
  ["@text.underline"] =   { fg = c.Fg, fmt = 'underline' },
  ["@text.strike"] =      { fg = c.Fg, fmt = 'strikethrough' },
}

hl.plugins.telescope = {
  TelescopeBorder =         { fg = c.Yellow },
  TelescopePromptBorder =   { fg = c.Gray },
  TelescopeResultsBorder =  { fg = c.Gray },
  TelescopePreviewBorder =  { fg = c.Gray },
  TelescopeMatching =       { fg = c.Yellow, fmt = "bold" },
  TelescopePromptPrefix =   { fg = c.Green },
  TelescopeSelection =      { fg = c.Bg, bg = c.Magenta },
  TelescopeSelectionCaret = { fg = c.Yellow },
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

for _, group in pairs(hl.plugins) do set_highlights(group) end
