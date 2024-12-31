local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorscheme
    {
        "navarasu/onedark.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            style = "warmer",
            code_style = {
                keywords = "bold",
            },
            colors = {
                bg0 = "#14171c",
            },
            highlights = {
                Todo = { fg = "$bg0" , bg = "$yellow" },
                StatusLine = { bg = "$bg1" },
                StatusLineMode = { bg = "$bg1", fmt = "bold" },
                ["@keyword.function"] = { fmt = "bold" },
                ["@tag.delimiter"] = { fg = "$dark_purple" },
            }
        },
        config = function(_, opts)
            -- require('onedark').setup(opts)
            -- require('onedark').load()
        end
    },

    -- Tresitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            -- ensure_installed = {
            --     "go",
            --     "javascript", "typescript",
            --     "tsx", "svelte", "vue"
            -- },
            highlight = {
                enable = false,
                disable = { "markdown", "c" },
            },
            auto_install = false,
            indent = { enable = true },
        },
        config = function(_, opts)
            local configs = require("nvim-treesitter.configs")
            configs.setup(opts)

            -- Disable css highlight only on css files
            -- vim.api.nvim_create_autocmd(
            --     "FileType",
            --     {
            --         group = vim.api.nvim_create_augroup(
            --             "DisableTSFileType", { clear = true }
            --         ),
            --         pattern = { "css" },
            --         command = ":TSBufDisable highlight"
            --     }
            -- )
        end
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require('lspconfig')

            -- lspconfig.ts_ls.setup {}
            -- lspconfig.gopls.setup {}
            -- lspconfig.volar.setup {}
            -- lspconfig.svelte.setup {}

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local keymap = vim.keymap.set
                    local opts = { buffer = ev.buf, noremap = true }

                    keymap("n", "<leader>K",  vim.lsp.buf.hover, opts)
                    keymap("n", "<leader>gd", vim.lsp.buf.definition, opts)
                    keymap("n", "<leader>gr", vim.lsp.buf.references, opts)
                    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    keymap("n", "<leader>dn", vim.diagnostic.goto_next, opts)
                    keymap("n", "<leader>dp", vim.diagnostic.goto_prev, opts)
                    keymap("n", "<leader>df", vim.diagnostic.open_float, opts)
                end
            })

            -- Disable virtual text (brother, ewww)
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = true,
                    virtual_text = false,
                    signs = false,
                    update_in_insert = false,
                }
            )
        end
    },

    -- Git
    {
        "NeogitOrg/neogit",
        dependencies = { "nvim-lua/plenary.nvim" }, -- required
        config = true
    },

    -- Oil
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            }
        },
    }
})
