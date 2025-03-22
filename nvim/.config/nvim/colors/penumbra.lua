vim.cmd("hi clear")
vim.g.colors_name = "penumbra"
vim.opt.background = "dark"
vim.opt.termguicolors = true

local c = {
    bg        = "#0a0a0a", -- bg
    cocos     = "#1d1d1d", -- light bg
    charcoal  = "#323232", -- lighter bg
    -- gray      = "#787878", -- grey
    gray      = "#7f7f7f", -- grey

    fg        = "#cecece", -- fg
    web       = "#b4aeb1", -- dark fg

    grotesque = "#69e49c", -- green
    pistachio = "#8bbf70", -- dark green
    neptune   = "#77c694", -- desaturate green

    peach     = "#fb7573", -- red
    easteregg = "#8195ca", -- blue
    -- easteregg = "#6998e4", -- blue
    spaghetti = "#ecce85", -- yellow
    -- mille     = "#eec780", -- yellow 2

    -- Still in doubt
    -- green = "#d1d8a8",
    -- fg = "#e3e3e3",
}

local hl = {}

hl.editor = {
    Normal         = { fg = c.fg, bg = c.bg },
    Visual         = { bg = c.charcoal },
    CursorLine     = { bg = c.cocos },
    StatusLine     = { bg = c.charcoal },
    StatusLineMode = { bg = c.charcoal },
    WinSeparator   = { fg = c.charcoal },
    Question       = { fg = c.grotesque },
    Title          = { fg = c.fg, fmt= "bold" },
    NormalFloat    = { bg = c.charcoal },
    Directory      = { fg = c.easteregg, fmt = "bold" },
    IncSearch      = { bg = c.spaghetti, fg = c.bg },
    Substitute     = { bg = c.spaghetti, fg = c.bg },
}

hl.syntax = {
    Comment =    { fg = c.gray },
    Constant =   { fg = c.easteregg },
    String =     { fg = c.spaghetti },
    Identifier = { fg = c.fg },
    Function =   { fg = c.fg, fmt = "bold" },
    Statement =  { fg = c.grotesque, fmt = "bold" },
    PreProc =    { fg = c.fg },
    Type =       { fg = c.neptune },
    Structure =  { fg = c.grotesque, fmt = "bold" },
    Typedef =    { fg = c.grotesque, fmt = "bold" },
    Special =    { fg = c.spaghetti },
    Error =      { fg = c.bg, bg = c.peach },
    Todo =       { fg = c.bg, bg = c.fg },
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
