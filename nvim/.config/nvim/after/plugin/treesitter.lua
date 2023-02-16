local status = pcall(require, "nvim-treesitter")
if (not status) then return end

require('nvim-treesitter.configs').setup {
  ensure_installed = { "tsx", "html", "css", "scss", "lua", "json", "bash", "python" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>'
    }
  },

  autotag = {
    enable = true,
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte',
      'vue', 'tsx', 'jsx', 'rescript', 'css', 'lua', 'xml', 'php', 'markdown'
    }
  },
}
