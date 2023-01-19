local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- <div class="{insert1}">{insert2}</div>
  s("class", {
    t('<div class="'),
    i(1, "class"),
    t('">'),
    i(2, ""),
    t("</div>")
  })
}
