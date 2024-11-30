local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
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
                -- bg0 = "#191d22",
                -- bg0 = "#0f1115",
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
            require('onedark').setup(opts)
            require('onedark').load()
        end
    },
    { "rebelot/kanagawa.nvim" },

    -- Tresitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "c", "go", "lua",
                "html", "css", "javascript", "typescript",
                "tsx", "svelte", "vue"
            },
            highlight = {
                enable = true,
                disable = { "markdown", "c" },
            },
            auto_install = false,
            indent = { enable = true },
        },
        config = function(_, opts)
            local configs = require("nvim-treesitter.configs")
            configs.setup(opts)

            vim.api.nvim_create_autocmd(
                "FileType",
                {
                    group = vim.api.nvim_create_augroup(
                        "DisableTSFileType", { clear = true }
                    ),
                    pattern = { "css" },
                    command = ":TSBufDisable highlight"
                }
            )
        end
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require('lspconfig')

            lspconfig.tsserver.setup { single_file_support = false, }
            lspconfig.denols.setup {
                single_file_support = false,
                root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
            }
            lspconfig.gopls.setup {}
            lspconfig.volar.setup {}
            lspconfig.svelte.setup {}

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
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required
            -- "sindrets/diffview.nvim", -- optional - Diff integration
        },
        config = true
    },

    -- Oil
    {
        'stevearc/oil.nvim',
        opts = {
            default_file_explorer = false,
        },
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    }
})
