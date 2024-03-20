local M = {}

-- if false then
--     vim.opt.cmdheight = 0
--     vim.api.nvim_create_autocmd(
--     "ModeChanged",
--     {
--         group = vim.api.nvim_create_augroup(
--         "StatusDisappear", { clear = true }
--         ),
--         callback = function()
--             if vim.v.event.new_mode == "c" then
--                 vim.opt.laststatus = 0
--             elseif vim.v.event.old_mode == "c" then
--                 vim.opt.laststatus = 3
--                 vim.cmd("redraw")
--             end
--         end,
--     }
--     )
-- end

M.mode = function()
    local current_mode = vim.fn.mode()
    local modes = {
        ['n']  = "NOR",
        ['i']  = "INS",
        ['v']  = "VIS",
        ['V']  = "VIS",
        ['^V'] = "BLO",
        ['c']  = "CMD",
        ['R']  = "REP",
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
        vim = "",
        help = "󰋗",
        sh = "",
        rust = "󱘗",
        c="",
        cpp="",
        go="",
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

-- M.lsp = function()
--     local buf = vim.api.nvim_get_current_buf()
--     local clients = vim.lsp.get_active_clients({ bufnr = buf })
--     if #clients == 0 then
--         return ""
--     end
--     local lsp_msg = ""
--     if #clients == 1 then
--         msg = " " .. clients[1].name
--     end
--     if #clients > 1 then
--         msg = msg .. " (+" .. #clients .. ")"
--     end
--     return msg
-- end

local stats = {
    "%#StatusLineMode#",
    "%{%v:lua.require'statusline'.mode()%} %#StatusLine#",
    "%<%f %{%v:lua.require'statusline'.icon()%} %m",
    "%=",
    -- "%{%v:lua.require'statusline'.lsp()%}",
    "%l:%c",
    "%y ",
}

vim.opt.statusline = table.concat(stats, " ")

return M
