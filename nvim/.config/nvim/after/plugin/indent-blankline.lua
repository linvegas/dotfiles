local status = pcall(require, "ibl")
if (not status) then return end

require("ibl").setup({
    indent = {
        char = "│",
        tab_char = ">"
    },
    scope = {
       show_start = false,
    },
})
