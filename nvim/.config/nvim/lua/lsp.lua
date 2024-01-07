local gopls = {
    cmd = { "gopls" },
    workspace_markers = { "go.work", "go.mod", ".git" },
    single_file = true,
}

local tsserver = {
    cmd = { "typescript-language-server", "--stdio", },
    workspace_markers = { "tsconfig.json", "package.json", },
    single_file = true,
    init_options = {
        hostInfo = "neovim",
        -- preferences = {
        --     quotePreference = "double",
        --     includeInlayVariableTypeHints = true,
        -- },
    },
    settings = {
        javascript = {
            format = {
                convertTabsToSpaces = true,
                semicolons = "insert",
                -- trimTrailingWhitespace = true,
            },
        },
        typescript = {
            format = {
                convertTabsToSpaces = true,
                semicolons = "insert",
                -- trimTrailingWhitespace = true,
            },
        },
    },
}

local servers = {
    go = gopls,
    typescript = tsserver,
    typescriptreact = tsserver,
    ["typescript.jsx"] = tsserver,
    javascript = tsserver,
    javascriptreact = tsserver,
    ["javascript.jsx"] = tsserver,
}

vim.api.nvim_create_autocmd(
    "FileType",
    {
        group = vim.api.nvim_create_augroup(
            "LspStart", { clear = true }
        ),
        pattern = vim.tbl_keys(servers),
        callback = function(event)
            local server_cmd = servers[event.match].cmd
            if vim.fn.executable(server_cmd[1]) == 0 then
                vim.notify(
                    "\"" .. executable .. "\" lsp server not found",
                    vim.log.levels.WARN
                )
                return
            end
            local w_markers = servers[event.match].workspace_markers
            local file_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
            local root_dir_matches = vim.fs.find(w_markers, {
                path = file_dir,
                upward = true,
                stop = os.getenv("HOME"),
            })
            if #root_dir_matches == 0 and not servers[event.match].single_file then
                vim.notify(
                    "No markers found for " .. event.match,
                    vim.log.levels.INFO
                )
                return
            end
            local root_dir = nil
            if #root_dir_matches > 0 then
                root_dir = vim.fs.dirname(root_dir_matches[1])
            end
            vim.lsp.start({
                cmd = server_cmd,
                root_dir = root_dir,
                settings = servers[event.match].settings,
                init_options = servers[event.match].init_options,
            })
        end,
    }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = false,
        update_in_insert = false,
    }
)

vim.api.nvim_create_autocmd(
    "LspAttach",
    {
        callback = function(event)
            local buffer = event.buf
            local keymap = vim.keymap.set
            keymap("n", "<leader>K", vim.lsp.buf.hover, { buffer = buffer, noremap = true })
            keymap("n", "<leader>gd", vim.lsp.buf.definition, { buffer = buffer, noremap = true })
            keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = buffer, noremap = true })
            keymap("n", "<leader>dn", vim.diagnostic.goto_next, { buffer = buffer, noremap = true })
            keymap("n", "<leader>dp", vim.diagnostic.goto_prev, { buffer = buffer, noremap = true })
        end
    }
)
