local M = {} -- Module

M.mode = function()
    local current_mode = vim.fn.mode()
    local modes = {
        ['n']  = "NOR",
        ['i']  = "INS",
        ['v']  = "VIS",
        ['V']  = "VIS",
        ['^V'] = "BLO",
        ['c']  = "CMD",
        ['R']  = "RPL",
        ['!']  = "SHE",
        ['t']  = "TER",
    }
    return modes[current_mode] or "---"
end

M.icon = function()
    local filetype = vim.opt.filetype:get()
    local map = {
        lua = "󰢱",
        netrw = "󰙅",
        oil = "󰙅",
        vim = "",
        help = "󰋗",
        sh = "",
        rust = "󱘗",
        c="",
        cpp="",
        go="",
        python="",
        html="",
        css="",
        typescript = "󰛦",
        typescriptreact = "󰛦",
        javascript = "󰌞",
        javascriptreact = "󰌞",
        svelte = "",
        vue = "",
    }
    local result = map[filetype] or ""
    return result
end

M.lsp = function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = buf })

    if #clients == 0 then
        return ""
    elseif #clients == 1  then
        msg = " " .. clients[1].name
    elseif #clients > 1  then
        msg = " " .. clients[1].name .. "+" .. #clients - 1
    end

    return msg
end

local stats = {
    "%#StatusLineMode#",
    "%{%v:lua.require'statusline'.mode()%} %#StatusLine#ⵘ",
    "%<%f %{%v:lua.require'statusline'.icon()%} %m",
    "%=",
    "%{%v:lua.require'statusline'.lsp()%}",
    "%l:%c",
    "%y ",
}

vim.opt.statusline = table.concat(stats, " ")

return M
