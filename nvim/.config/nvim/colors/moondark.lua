vim.cmd.highlight("clear")
vim.g.colors_name = "moondark"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local c = {
    bg          = "#131313",
    fg          = "#d8d8d8",

    bg_light1   = "#282828",
    bg_light2   = "#383838",

    gray        = "#585858",
    gray_light  = "#777777",

    -- red         = "#ab4642",
    red         = "#c87e78",
    -- green       = "#a1b56c",
    green       = "#b3c48a",
    blue        = "#7cafc2",
    -- blue        = "#89b7c8",
    cyan        = "#86c1b9",
    yellow      = "#f7ca88",
    magenta     = "#ba8baf",
    -- magenta     = "#c8a2bf",
}

local hl = {}

hl.editor = {
    Normal         = { fg = c.fg, bg = c.bg },
    Visual         = { bg = c.bg_light2 },
    CursorLine     = { bg = c.bg_light1 },
    StatusLine     = { bg = c.bg_light1 },
    StatusLineMode = { bg = c.bg_light1, fmt = "bold" },
    WinSeparator   = { fg = c.bg_light2 },
    Question       = { fg = c.fg },
    Title          = { fg = c.fg, fmt= "bold" },
    NormalFloat    = { bg = c.bg },
    Directory      = { fg = c.blue, fmt = "bold" },
    IncSearch      = { bg = c.yellow, fg = c.bg_light1 },
    Substitute     = { bg = c.yellow, fg = c.bg_light1 },
}

hl.syntax = {
    Comment    = { fg = c.gray_light },
    Constant   = { fg = c.red },
    String     = { fg = c.green },
    Identifier = { fg = c.fg },
    Function   = { fg = c.fg },
    Statement  = { fg = c.magenta, fmt = "bold" },
    Operator   = { fg = c.fg },
    PreProc    = { fg = c.fg, fmt = "bold" },
    Type       = { fg = c.yellow },
    Structure  = { fg = c.magenta, fmt = "bold" },
    Typedef    = { fg = c.magenta, fmt = "bold" },
    Special    = { fg = c.fg },
    Delimiter  = { fg = c.fg },
    Error      = { fg = c.red, bg = c.bg },
    ErrorMsg   = { fg = c.red, bg = c.bg },
    Todo       = { fg = c.bg, bg = c.yellow },
    Added      = { fg = c.green },
    Changed    = { fg = c.cyan },
    Removed    = { fg = c.red },
}

hl.treesitter = {
    ["@variable"]      = { fg = c.fg },
    ["@type.builtin"]  = hl.syntax.Type,
    ["@function.call"] = { fg = c.blue },
}

hl.html = {
    htmlTag    = { fg = c.gray_light },
    htmlEndTag = { fg = c.gray_light },
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
set_highlights(hl.treesitter)
set_highlights(hl.html)
