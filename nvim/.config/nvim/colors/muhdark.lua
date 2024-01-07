-- My own version of the onedark.nvim colorscheme plugin

vim.cmd("hi clear")
vim.g.colors_name = "muhdark"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local hl = {}

local c = {
    Black    = "#101012",
    Bg0      = "#1f2329",
    Bg1      = "#2c2d31",
    Bg2      = "#35363b",
    Bg3      = "#37383d",
    Fg0      = "#a7aab0",
    Grey0    = "#5a5b5e",
    Grey1    = "#818387",
    Blue1    = "#68aee8",
    Green1   = "#99bc80",
    Green2   = "#015825",
    Red1     = "#e16d77",
    Red2     = "#914141",
    Cyan1    = "#5fafb9",
    Cyan2    = "#316a71",
    Yellow1  = "#dfbe81",
    Yellow2  = "#8c6724",
    Orange0  = "#c99a6e",
    Magenta1 = "#c27fd7",
    Magenta2 = "#79428a",
}

hl.editor = {
    Normal =       { fg = c.Fg0, bg = c.Bg0 },
    Visual =       { bg = c.Bg3 },
    StatusLine =   { fg = c.Fg0, bg = c.Black },
    Tabline =      { fg = c.Fg0, bg = c.Bg1 },
    TablineFill =  { fg = c.Fg0, bg = c.Bg0 },
    TablineSel =   { fg = c.Bg0, bg = c.Fg0 },
    LineNr =       { fg = c.Grey0 },
    Cursor =       { fmt = "reverse" },
    lCursor =      { fmt = "reverse" },
    CursorIM =     { fmt = "reverse" },
    CursorLine   = { bg = c.Bg1 },
    CursorLineNr = { fg = c.Fg0, fmt = "bold" },
    Pmenu =        { bg = c.Bg3 },
    PmenuSel =     { fg = c.Bg0, bg = c.Fg0 },
    PmenuSbar =    { bg = c.Grey0 },
    PmenuThumb =   { bg = c.Fg0 },
    Whitespace =   { fg = c.Grey0 },
    NonText =      { fg = c.Grey0 },
    IncSearch =    { fg = c.Bg3, bg = c.Yellow1 },
    Substitute =   { fg = c.Bg3, bg = c.Yellow1 },
    ErrorMsg =     { fg = c.Red1, bg = c.Red2, fmt = "bold" },
    WarningMsg =   { fg = c.Yellow1, bg = c.Yellow2, fmt = "bold" },
    WinSeparator = { fg = c.White4 },
    Directory =    { fg = c.Blue1 },
    QuickFixLine = { fg = c.Blue1, fmt = "underline" },
}

hl.syntax = {
    Comment =        { fg = c.Grey0},
    Constant =       { fg = c.Cyan1},
    String =         { fg = c.Green1 },
    Character =      { fg = c.Orange0},
    Number =         { fg = c.Orange0},
    Boolean =        { fg = c.Orange0},
    Float =          { fg = c.Orange0},
    Identifier =     { fg = c.Blue1},
    Function =       { fg = c.Blue1},
    Statement =      { fg = c.Magenta1, fmt = "bold" },
    Operator =       { fg = c.Cyan1 },
    Type =           { fg = c.Yellow1 },
    PreProc =        { fg = c.Magenta1 },
    Macro =          { fg = c.Red1 },
    Special =        { fg = c.Red1 },
    Underlined =     { fg = c.Fg0, fmt = "underline" },
    Error =          { fg = c.Red2, bg = c.Red1 },
    Todo =           { fg = c.Yellow2, bg = c.Yellow1 },
    Title =          { fmt = "bold" },
    Tag =            { fg = c.Green1 },
}

hl.statusline = {
    -- StatusLine =   { fg = c.Fg0, bg = c.Grey1 },
    StatusLineMode = { fg = c.Fg0, fmt = "bold" },
}

hl.lsp = {
    DiagnosticError =                    { fg = c.Red1 },
    DiagnosticHint =                     { fg = c.Magenta1 },
    DiagnosticInfo =                     { fg = c.Cyan1 },
    DiagnosticWarn =                     { fg = c.Yellow1 },
    LspDiagnosticsDefaultError =         { fg = c.Red1 },
    LspDiagnosticsDefaultHint =          { fg = c.Magenta1 },
    LspDiagnosticsDefaultInformation =   { fg = c.Cyan1 },
    LspDiagnosticsDefaultWarning =       { fg = c.Yellow1 },
    DiagnosticUnderlineError =           { fmt = "undercurl" or "underline", sp = c.Red1 },
    DiagnosticUnderlineHint =            { fmt = "undercurl" or "underline", sp = c.Magenta1 },
    DiagnosticUnderlineInfo =            { fmt = "undercurl" or "underline", sp = c.Blue1 },
    DiagnosticUnderlineWarn =            { fmt = "undercurl" or "underline", sp = c.Yellow1 },
    LspDiagnosticsUnderlineError =       { fmt = "undercurl" or "underline", sp = c.Red1 },
    LspDiagnosticsUnderlineHint =        { fmt = "undercurl" or "underline", sp = c.Magenta1 },
    LspDiagnosticsUnderlineInformation = { fmt = "undercurl" or "underline", sp = c.Blue1 },
    LspDiagnosticsUnderlineWarning =     { fmt = "undercurl" or "underline", sp = c.Yellow1 },
    LspReferenceText =                   { bg = c.Bg2 },
    LspReferenceWrite =                  { bg = c.Bg2 },
    LspReferenceRead =                   { bg = c.Bg2 },
}

hl.c = {
    cInclude = { fg = c.Blue1 },
    cTypedef = { fg = c.Magenta1 },
    cDefine =  { fg = c.Blue1 },
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
set_highlights(hl.c)
