local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local usercmd = vim.api.nvim_create_user_command

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

local svelteserver = {
    cmd = { "svelteserver", "--stdio", },
    workspace_markers = { "svelte.config.js", "package.json", ".git" },
}

local volar = {
    cmd = { "vue-language-server", "--stdio" },
    workspace_markers = { "package.json" },
    init_options = {
        typescript = {
            -- TODO: Use the local typescrpit lib and fallback
            -- to global typescript lib
            tsdk = "/usr/lib/node_modules/typescript/lib"
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
    svelte = svelteserver,
    vue = volar,
}

autocmd(
    "FileType",
    {
        group = augroup(
            "LspStart", { clear = true }
        ),
        pattern = vim.tbl_keys(servers),
        callback = function(event)
            local server_cmd = servers[event.match].cmd
            if vim.fn.executable(server_cmd[1]) == 0 then
                vim.notify(
                    "\"" .. server_cmd[1] .. "\" lsp server not found",
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

autocmd(
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
            keymap("n", "<leader>df", vim.diagnostic.open_float, { buffer = buffer, noremap = true })
        end
    }
)

-- Todo: Restart only client on current buffer
usercmd(
    "LSPRestart",
    function()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        vim.cmd("edit")
    end, {}
)

