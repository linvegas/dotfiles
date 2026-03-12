-- Originally inspired by the Base16 Default Dark colorscheme
-- https://github.com/chriskempson/base16-default-schemes

vim.cmd.highlight("clear")
vim.g.colors_name = "moondark"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local c = {
    bg          = "#0f0f0f",
    fg          = "#d8d8d8",

    bg_light1   = "#282828",
    bg_light2   = "#383838",

    fg_dark     = "#b8b8b8",

    gray        = "#585858",
    gray_light  = "#777777",

    red         = "#c87e78",
    orange      = "#e0a168",
    green       = "#b3c48a",
    blue        = "#7cafc2",
    cyan        = "#86c1b9",
    yellow      = "#f7ca88",
    magenta     = "#ba8baf",
}

local hl = {}

hl.editor = {
    Normal         = { fg = c.fg, bg = c.bg },
    Visual         = { bg = c.bg_light2 },

    Cursor         = { fg = c.bg, bg = c.fg },
    CursorLine     = { bg = c.bg_light1 },
    CursorColumn   = { bg = c.bg_light1 },
    CursorLineNr   = { fg = c.fg, fmt = "bold" },
    LineNr         = { fg = c.gray },
    LineNrAbove    = { fg = c.gray },
    LineNrBelow    = { fg = c.gray },

    StatusLine     = { bg = c.bg_light1, fg = c.fg_dark },
    StatusLineMode = { bg = c.bg_light1, fmt = "bold" },
    WinSeparator   = { fg = c.bg_light2 },
    Question       = { fg = c.fg },
    Title          = { fg = c.fg, fmt= "bold" },
    NormalFloat    = { bg = c.bg },
    Directory      = { fg = c.blue, fmt = "bold" },

    Search         = { bg = c.bg_light2, fg = c.fg },
    CurSearch      = { bg = c.yellow, fg = c.bg },
    IncSearch      = { bg = c.yellow, fg = c.bg },
    Substitute     = { bg = c.yellow, fg = c.bg },

    Pmenu          = { bg = c.bg_light1, fg = c.fg },
    PmenuSel       = { bg = c.fg, fg = c.bg_light1 },
    PmenuSbar      = { bg = c.bg_light2 },
    PmenuThumb     = { bg = c.gray },

    TabLine        = { bg = c.bg_light1, fg = c.gray },
    TabLineSel     = { bg = c.gray, fg = c.fg, fmt = "bold" },
    TabLineFill    = { bg = c.bg },

    Folded         = { fg = c.gray_light, bg = c.bg_light1 },
    FoldColumn     = { fg = c.gray },

    MatchParen     = { bg = c.gray },
    NonText        = { fg = c.gray },
    SpecialKey     = { fg = c.gray },
    Whitespace     = { fg = c.bg_light2 },
    SignColumn     = { bg = c.bg },
    ColorColumn    = { bg = c.bg_light1 },
    ModeMsg        = { fg = c.fg, fmt = "bold" },
    MoreMsg        = { fg = c.green },
    WarningMsg     = { fg = c.yellow },
    WildMenu       = { bg = c.bg_light2, fg = c.fg },

    QuickFixLine   = { bg = c.bg_light2, fg = c.fg },
    qfFileName     = { fg = c.blue },
    qfLineNr       = { fg = c.gray_light },
    qfError        = { fg = c.red },

    DiagnosticError          = { fg = c.red },
    DiagnosticWarn           = { fg = c.yellow },
    DiagnosticInfo           = { fg = c.blue },
    DiagnosticHint           = { fg = c.cyan },
    DiagnosticUnnecessary    = { fg = c.gray },

    DiagnosticUnderlineError = { fmt = "undercurl" },
    DiagnosticUnderlineWarn  = { fmt = "undercurl" },
    DiagnosticUnderlineInfo  = { fmt = "underline" },
    DiagnosticUnderlineHint  = { fmt = "underline" },
}

hl.syntax = {
    Comment    = { fg = c.gray_light },
    Constant   = { fg = c.red },
    String     = { fg = c.green },
    Identifier = { fg = c.fg },
    Function   = { fg = c.blue },
    Statement  = { fg = c.magenta, fmt = "bold" },
    Operator   = { fg = c.fg },
    PreProc    = { fg = c.fg, fmt = "bold" },
    Include    = { fg = c.magenta },
    Type       = { fg = c.yellow },
    Structure  = { fg = c.magenta, fmt = "bold" },
    Typedef    = { fg = c.magenta, fmt = "bold" },
    Special    = { fg = c.cyan },
    Delimiter  = { fg = c.fg },
    Error      = { fg = c.red, bg = c.bg },
    ErrorMsg   = { fg = c.red, bg = c.bg },
    Todo       = { fg = c.bg, bg = c.yellow },
    Added      = { fg = c.green },
    Changed    = { fg = c.cyan },
    Removed    = { fg = c.red },
    SpellBad   = { fg = c.red, fmt = "undercurl" },
    SpellWarn  = { fg = c.yellow, fmt = "undercurl" },
    Conceal    = { fg = c.gray_light },
    Ignore     = { fg = c.gray_light },
    DiffAdd    = { fg = c.green },
    DiffChange = { fg = c.cyan },
    DiffDelete = { fg = c.red },
    DiffText   = { fg = c.yellow },
    Debug      = { fg = c.yellow },
}

hl.neogit = {
    NeogitBranch               = { fg = c.magenta },
    NeogitRemote               = { fg = c.green },
    NeogitUnmergedInto         = { fg = c.magenta },
    NeogitUnpushedTo           = { fg = c.magenta },
    NeogitUnstagedchanges      = { fg = c.orange },
    NeogitStagedchanges        = { fg = c.cyan, fmt = "bold,italic" },
    NeogitChangeModified       = { fg = c.yellow, fmt = "bold,italic" },

    NeogitSectionHeader        = { fg = c.blue, fmt = "bold" },
    NeogitPopupSectionTitle    = { fg = c.fg, fmt = "bold" },
    NeogitHunkHeader           = { bg = c.bg_light1, fg = c.fg },
    NeogitHunkHeaderHighlight  = { bg = c.bg_light2, fg = c.fg, fmt = "bold" },

    NeogitDiffAdd              = { fg = c.green, bg = c.bg_light1 },
    NeogitDiffDelete           = { fg = c.red,   bg = c.bg_light1 },
    NeogitDiffContext          = { bg = c.bg },
    NeogitDiffAddHighlight     = { fg = c.green, bg = c.bg_light2 },
    NeogitDiffDeleteHighlight  = { fg = c.red,  bg = c.bg_light2 },
    NeogitDiffContextHighlight = { bg = c.bg_light1 },

    NeogitCommitViewHeader     = { bg = c.bg_light2, fg = c.fg },
    NeogitFilePath             = { fg = c.blue },
    NeogitUntrackedfiles       = { fg = c.fg, fmt = "bold" },
    NeogitUnstagedchanges      = { fg = c.fg, fmt = "bold" },
    NeogitStagedchanges        = { fg = c.fg, fmt = "bold" },
    NeogitStashes              = { fg = c.fg, fmt = "bold" },

    NeogitNotificationInfo     = { fg = c.blue },
    NeogitNotificationWarning  = { fg = c.yellow },
    NeogitNotificationError    = { fg = c.red },
}

hl.treesitter = {
    ["@variable"]      = { fg = c.fg },
    ["@type.builtin"]  = hl.syntax.Type,
    ["@function.call"] = { fg = c.blue },
    ["@function.method.call"] = { fg = c.blue },
    ["@function.builtin"] = { fg = c.blue },
}

-- hl.html = {
--     htmlTag    = { fg = c.gray_light },
--     htmlEndTag = { fg = c.gray_light },
-- }

hl.rust = {
    rustFuncCall = { fg = c.blue },
    rustModPath = { fg = c.yellow },
}

hl.js = {
    javaScriptFunctionCall = { fg = c.blue },
}

hl.markdown = {
    markdownH1 = { bg = c.blue, fg = c.bg, fmt = "bold" },
    markdownH2 = { fg = c.blue, fmt = "bold" },
    markdownH3 = { fg = c.yellow, fmt = "bold" },
    markdownH1Delimiter = { bg = c.blue, fg = c.bg, fmt = "bold" },
    markdownH2Delimiter = { fg = c.blue, fmt = "bold" },
    markdownH3Delimiter = { fg = c.yellow, fmt = "bold" },
    markdownBold = { fmt = "bold" },
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

for _, groups in pairs(hl) do
    set_highlights(groups)
end
