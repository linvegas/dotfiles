local status = pcall(require, "luasnip")
if (not status) then return end

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets"})
