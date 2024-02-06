local aucmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

-- Deletes trailling whitespace on every save
aucmd(
    "BufWritePre",
    {
        group = augroup(
            "WhitespaceCleaner", { clear = true }
        ),
        pattern = "*",
        command = ":%s/\\s\\+$//e"
    }
)

-- Highlight yanked text
aucmd(
    "TextYankPost",
    {
        group = augroup(
            "YankHighlight", { clear = true }
        ),
        pattern = "*",
        callback = function()
            vim.highlight.on_yank()
        end,
    }
)

-- Remeber cursor last position
aucmd(
    "BufReadPost",
    {
        group = augroup(
            "RememberLastPosition", { clear = true }
        ),
        pattern = "*",
        callback = function()
            local row, column = unpack(vim.api.nvim_buf_get_mark(0, '"'))
            local buf_line_count = vim.api.nvim_buf_line_count(0)
            if row >= 1 and row <= buf_line_count then
                vim.api.nvim_win_set_cursor(0, { row, column })
            end
        end,
    }
)

-- Remove line numbers and start in insert mode on terminal mode
aucmd(
    "TermOpen",
    {
        group = augroup(
            "CleanTerminal", { clear = true }
        ),
        pattern = "*",
        command = "setlocal nonumber norelativenumber | startinsert"
    }
)

-- Set current directory on vim to file's current directory
-- when openning vim on command line
aucmd(
    "VimEnter",
    {
        group = augroup(
            "SetCurrentDirectory", { clear = true }
        ),
        pattern = "*",
        callback = function(event)
            local dir = event.file
            if vim.fn.isdirectory(dir) == 0 then
                dir = vim.fs.dirname(dir)
            end
            vim.cmd.cd(dir)
        end,
        once = true,
    }
)

aucmd(
    "FileType",
    {
        group = augroup(
            "WebshitterStandards", { clear = true }
        ),
        pattern = {
            "javascript", "typescript", "html", "css", "svelte",
            "javascriptreact", "typescriptreact", "json"
        },
        callback = function()
            vim.opt_local.tabstop = 2
            vim.opt_local.softtabstop = 2
            vim.opt_local.shiftwidth = 2
            vim.opt_local.listchars = "tab:> ,trail:•,extends:>,leadmultispace:│ "
            vim.opt_local.list = true
        end,
    }
)

-- Load a shebang on every new shell file
aucmd(
    "BufNewFile",
    {
        group = augroup("ShellBoilerPlate", { clear = true }),
        pattern = "*.sh",
        command = "0r $HOME/.config/nvim/templates/shell.sh"
    }
)

-- User command for loading personal templates
usercmd(
    "Loadtemp",
    function(opts)
        local path = vim.fn.stdpath "config" .. "/templates"
        local content = vim.fn.readfile(path .. "/" .. opts.fargs[1])
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_buf_set_lines(0, cursor_pos[1] - 1, cursor_pos[1] - 1, false, content)
    end,
    {
        nargs = 1,
        complete = function(ArgLead, CmdLine, CursorPos)
            local templates = vim.api.nvim_get_runtime_file("templates/*", true)
            local filenames = {}
            for i, file in ipairs(templates) do
                filenames[i] = file:match("([^/]+)$")
            end
            return filenames
        end,
    }
)

