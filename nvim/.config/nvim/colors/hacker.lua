vim.cmd("hi clear")
vim.g.colors_name = "hacker"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local c = {
    black = "#101010",
    bg = "#1e211f",
    bg2 = "#313332",
    bg3 = "#444745",
    fg = "#c8dbdb",
    grey = "#858786",
    green = "#25cd92",
    blue = "#62bee3",
    cyan = "#73eeef",
    orange = "#e8c771",
    red = "#e29f7e",
    magenta = "#d099e0",
}

local hl = {}

hl.editor = {
    Normal = { fg = c.fg, bg = c.bg },
    Visual = { bg = c.bg2 },
    LineNr = { fg = c.bg3 },
    CursorLineNr = { fg = c.fg },
    Whitespace = { fg = c.bg3 },
    CursorLine = { bg = c.bg2 },
    StatusLine = { fg = c.fg, bg = c.bg3 },
}

hl.syntax = {
    String = { fg = c.green },
    Comment = { fg = c.grey },
    Constant = { fg = c.red },
    Statement = { fg = c.green, fmt = "bold" },
    Operator = { fg = c.fg },
    Identifier = { fg = c.fg },
    Function = { fg = c.fg, fmt = "bold"},
    PreProc = { fg = c.green },
    Type = { fg = c.orange },
    Macro = { fg = c.cyan, fmt = "bold" },
    Special = { fg = c.fg, fmt = "bold" },
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
