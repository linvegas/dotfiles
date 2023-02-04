local status, bufferline = pcall(require, 'bufferline')
if (not status) then return end

vim.opt.termguicolors = true

bufferline.setup {
  options = {
    mode = "tabs",
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    separator_style = "thin",
  },
  highlights = {
    buffer_selected = {
      italic = false,
    },
  }
}
