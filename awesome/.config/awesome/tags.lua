local awful = require("awful")

-- Each screen has its own tag table.
local tag_names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
local layout = awful.layout.suit

awful.screen.connect_for_each_screen(function(s)
    awful.tag(tag_names, s, layout.tile)
end)
