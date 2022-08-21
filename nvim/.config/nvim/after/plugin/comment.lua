local status = pcall(require, "Comment")
if (not status) then return end

require('Comment').setup {
  opleader = {
    line = 'gc',  ---Line-comment keymap
    block = 'gb', ---Block-comment keymap
  },

  mappings = {
    --- 'gc[count]c' line-comment line
    --- 'gc[count]b' block-comment line
    basic = true,
    --- 'gco' new line with line-comment
    --- 'gcO' new line with line-comment
    --- 'gca' end of line with line-comment
    extra = true,
    extended = false,
  },

  toggler = {
    line = 'gcc',  ---Line-comment toggle keymap
    block = 'gbc', ---Block-comment toggle keymap
  },

  padding = true,
}
