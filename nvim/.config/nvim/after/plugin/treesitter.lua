local status = pcall(require, "nvim-treesitter")
if (not status) then return end

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "tsx", "html", "css", "scss", "lua", "json", "bash", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,
    disable = {},
  },

  autotag = {
    enable = true,
  },
}
