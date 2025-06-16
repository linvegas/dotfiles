-- Deletes trailling whitespace on every save
vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        group = vim.api.nvim_create_augroup(
            "WhitespaceCleaner", { clear = true }
        ),
        pattern = "*",
        command = ":%s/\\s\\+$//e"
    }
)

-- Highlight yanked text
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        group = vim.api.nvim_create_augroup(
            "YankHighlight", { clear = true }
        ),
        pattern = "*",
        callback = function()
            vim.highlight.on_yank()
        end,
    }
)

-- Remeber cursor last position
vim.api.nvim_create_autocmd(
    "BufReadPost",
    {
        group = vim.api.nvim_create_augroup(
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
vim.api.nvim_create_autocmd(
    "TermOpen",
    {
        group = vim.api.nvim_create_augroup(
            "CleanTerminal", { clear = true }
        ),
        pattern = "*",
        command = "setlocal nonumber norelativenumber"
    }
)

-- Set current directory on vim to file's current directory
-- when openning vim on command line
-- vim.api.nvim_create_autocmd(
--     "VimEnter",
--     {
--         group = vim.api.nvim_create_augroup(
--             "SetCurrentDirectory", { clear = true }
--         ),
--         pattern = "*",
--         callback = function(event)
--             local dir = event.file
--             if vim.fn.isdirectory(dir) == 0 then
--                 dir = vim.fs.dirname(dir)
--             end
--             vim.cmd.cd(dir)
--         end,
--         once = true,
--     }
-- )

-- User command for loading personal templates
vim.api.nvim_create_user_command(
    "Template",
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

-- User command for listing last visited buffers
vim.api.nvim_create_user_command(
    "Buffer",
    function(opts)
        local selected_buf = opts.fargs[1]
        if selected_buf ~= '' then
            vim.api.nvim_command('buffer ' .. selected_buf)
        end
    end,
    {
        nargs = 1,
        complete = function(ArgLead, CmdLine, CursorPos)
            local buffers = vim.fn.getbufinfo({buflisted = 1})
            table.sort(buffers, function(a, b) return a.lastused > b.lastused end)

            buflist = {}

            for _, buf in ipairs(buffers) do
                local bufname = vim.fn.fnamemodify(buf.name, ':~:.')
                table.insert(buflist, bufname)
            end

            local last_visited_buf = vim.fn.bufname(vim.fn.bufnr('#'))

            if last_visited_buf ~= "" then
                for i, buf in ipairs(buflist) do
                    if buf == last_visited_buf then
                        table.remove(buflist, i)
                        break
                    end
                end

                table.insert(buflist, 1, last_visited_buf)
            end

            return buflist
        end,
    }
)
