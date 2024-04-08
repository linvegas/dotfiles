vim.cmd("hi clear")
vim.g.colors_name = "term"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local c = {
    bg = "#242424",
    fg = "#d6fff1",
    grey = "#487370",
    grey2 = "#333C3B",
    green = "#00f2a1",
    cyan = "#00F1F2",
    orange = "#ffcd53",
}

local hl = {}

hl.editor = {
    Normal = { fg = c.fg, bg = c.bg },
    LineNr = { fg = c.grey },
    Whitespace = { fg = c.grey },
    CursorLine = { bg = c.grey2 },
    StatusLine = { fg = c.fg, bg = c.grey },
}

hl.syntax = {
    String = { fg = c.green },
    Comment = { fg = c.grey },
    Statement = { fg = c.green, fmt = "bold" },
    Operator = { fg = c.fg },
    Identifier = { fg = c.fg, fmt = "bold"},
    Function = { fg = c.cyan},
    PreProc = { fg = c.green },
    Type = { fg = c.orange },
    Macro = { fg = c.cyan, fmt = "bold" },
    Special = { fg = c.fg, fmt = "bold" },
}

hl.rust = {
    rustModPath = { fg = c.orange }
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
set_highlights(hl.rust)
