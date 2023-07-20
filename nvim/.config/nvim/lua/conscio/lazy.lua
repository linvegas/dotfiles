-- Installs lazy.nvim if not already
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    lazy = false,
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'warmer',
        transparent = true,
        highlights = {
          StatusLine = {bg = 'none', fmt = 'bold'}
        }
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = {
      fast_wrap = {},
      --disable_filetype = { "TelescopePrompt" },
      enable_check_bracket_line = false
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      require("conscio.plugins.autopairs")
    end,
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = { window = { blend = 0 }} },

      { 'jose-elias-alvarez/null-ls.nvim', event = "VeryLazy",
        opts = function()
          return require("conscio.plugins.null-ls")
        end
      },

      -- Additional lua configuration for neovim
      'folke/neodev.nvim',
    },
    config = function()
      require("conscio.plugins.lspconfig")
    end,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Vscode snippets
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      require("conscio.plugins.cmp")
    end,
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag"
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      return require("conscio.plugins.treesitter")
    end,
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",
    opts = function()
      return require "conscio.plugins.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      -- load extensions
      --for _, ext in ipairs(opts.extensions_list) do
      --  telescope.load_extension(ext)
      --end
    end,
  },
})
