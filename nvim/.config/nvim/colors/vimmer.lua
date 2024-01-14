vim.cmd("hi clear")
vim.g.colors_name = "vimmer"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local hl = {}

local c = {
    Grey1    = "#0a0b10",
    Grey2    = "#1c1d23",
    Grey3    = "#2c2e33",
    Grey4    = "#4f5258",
    White1   = "#ebeef5",
    White2   = "#d7dae1",
    White3   = "#c4c6cd",
    White4   = "#9b9ea4",
    Blue1    = "#9fd8ff",
    Blue2    = "#005078",
    Green1   = "#aaedb7",
    Green2   = "#015825",
    Red1     = "#ffbcb5",
    Red2     = "#5e0009",
    Cyan1    = "#83efef",
    Cyan2    = "#007676",
    Yellow1  = "#f4d88c",
    Yellow2  = "#6e5600",
    Magenta1 = "#ffc3fa",
    Magenta2 = "#4c0049",
}

hl.editor = {
    Normal =       { fg = c.White3, bg = c.Grey2 },
    Visual =       { bg = c.Grey3 },
    StatusLine =   { fg = c.White3, bg = c.Grey1 },
    Tabline =      { fg = c.White3, bg = c.Grey3 },
    TablineFill =  { fg = c.White3, bg = c.Grey2 },
    TablineSel =   { fg = c.Grey2, bg = c.White2 },
    LineNr =       { fg = c.Grey4 },
    Cursor =       { fmt = "reverse" },
    lCursor =      { fmt = "reverse" },
    CursorIM =     { fmt = "reverse" },
    CursorLine   = { bg = c.Grey3 },
    CursorLineNr = { fg = c.White3, fmt = "bold" },
    Pmenu =        { bg = c.Grey3 },
    PmenuSel =     { fg = c.Grey2, bg = c.White2 },
    PmenuSbar =    { bg = c.Grey4 },
    PmenuThumb =   { bg = c.White3 },
    Whitespace =   { fg = c.Grey4 },
    NonText =      { fg = c.Grey4 },
    IncSearch =    { fg = c.Grey3, bg = c.Yellow1 },
    Substitute =   { fg = c.Grey3, bg = c.Yellow1 },
    ErrorMsg =     { fg = c.Red1, bg = c.Red2, fmt = "bold" },
    WarningMsg =   { fg = c.Yellow1, bg = c.Yellow2, fmt = "bold" },
    WinSeparator = { fg = c.White4 },
    Directory =    { fg = c.Blue1 },
    QuickFixLine = { fg = c.Blue1, fmt = "underline" },
}

hl.syntax = {
    Comment =        { fg = c.Grey4},
    Constant =       { fg = c.Cyan1},
    String =         { fg = c.Green1 },
    Character =      { fg = c.Red1},
    Number =         { fg = c.Red1},
    Boolean =        { fg = c.Red1},
    Float =          { fg = c.Red1},
    Identifier =     { fg = c.Blue1},
    Function =       { fg = c.Blue1},
    Statement =      { fg = c.White2, fmt = "bold" },
    Operator =       { fg = c.Magenta1 },
    Type =           { fg = c.Yellow1 },
    PreProc =        { fg = c.Magenta1 },
    Special =        { fg = c.Red1 },
    Underlined =     { fg = c.White3, fmt = "underline" },
    Error =          { fg = c.Red2, bg = c.Red1 },
    Todo =           { fg = c.Yellow2, bg = c.Yellow1 },
    Title =          { fmt = "bold" },
}

hl.statusline = {
    -- StatusLine =   { fg = c.White3, bg = c.Grey1 },
    StatusLineMode = { fg = c.White3, fmt = "bold" },
}

hl.lsp = {
    DiagnosticUnderlineError = { fmt = "undercurl" or "underline", sp = c.Red1},
    DiagnosticUnderlineHint =  { fmt = "undercurl" or "underline", sp = c.Magenta1},
    DiagnosticUnderlineInfo =  { fmt = "undercurl" or "underline", sp = c.Blue1},
    DiagnosticUnderlineWarn =  { fmt = "undercurl" or "underline", sp = c.Yellow1},
}

local function set_highlights(groups)
    for group_name, group_opts in pairs(groups) do
        vim.api.nvim_command(string.format(
            "highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,
            group_opts.fg or "none", group_opts.bg or "none",
            group_opts.sp or "none", group_opts.fmt or "none"
        ))
    end
end

set_highlights(hl.editor)
set_highlights(hl.syntax)
set_highlights(hl.statusline)
set_highlights(hl.lsp)
