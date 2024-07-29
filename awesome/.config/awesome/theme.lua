local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme_wallpaper = gfs.get_configuration_dir() .. "wallpaper.png"

local theme = {}

theme.font               = "DroidSansM Nerd Font Mono 10"

-- theme.bg                 = "#1f2329"
theme.bg                 = "#14171c"
-- theme.bg_light           = "#282c34"
-- theme.bg_light           = "#1f2329"
theme.bg_light           = "#272a2f"
-- theme.bg_lighter         = "#30363f"
theme.bg_lighter         = "#3b3e43"
-- theme.bg_lighter2        = "#323641"
theme.bg_lighter2        = "#676a6d"
theme.fg_normal          = "#ABB2BF"
theme.blue               = "#4fa6ed"
theme.green              = "#8ebd6b"
theme.purple             = "#bf68d9"
theme.purple_d           = "#7e3992"
theme.black              = "#0e1013"
theme.grey               = "#535965"

theme.useless_gap        = dpi(0)
theme.border_width       = dpi(1)
theme.rounded            = gears.shape.rounded_rect
theme.border_normal      = theme.black
theme.border_focus       = theme.grey

theme.wallpaper          = theme_wallpaper

theme.tasklist_bg_focus  = theme.bg_lighter
theme.tasklist_bg_normal = theme.bg_light

theme.titlebar_bg_focus  = theme.bg_lighter
theme.titlebar_bg_normal = theme.bg_light

theme.taglist_bg_focus   = theme.purple
theme.taglist_fg_focus   = theme.black
theme.taglist_bg_occupied = theme.bg_light
theme.taglist_fg_occupied = theme.fg_normal

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.purple_d
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Layout icons:
theme.layout_fairh      = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv      = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating   = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier  = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max        = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile       = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop    = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral     = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle    = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw   = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne   = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw   = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse   = themes_path .. "default/layouts/cornersew.png"

-- Titlebar icons
theme.titlebar_close_button_normal              = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = themes_path .. "default/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = themes_path .. "default/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = themes_path .. "default/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = themes_path .. "default/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = themes_path .. "default/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = themes_path .. "default/titlebar/maximized_focus_active.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_bg_focus = theme.blue
theme.menu_fg_focus = theme.bg
theme.menu_bg_normal = theme.bg
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(20)
theme.menu_width  = dpi(110)

theme.tooltip_bg = theme.bg_lighter
theme.tooltip_fg = theme.fg_normal
theme.tooltip_gaps = dpi(4)
theme.tooltip_shape = theme.rounded

theme.hotkeys_bg = theme.black
theme.hotkeys_modifiers_fg = theme.fg_normal
theme.hotkeys_shape = theme.rounded
-- theme.hotkeys_group_margin = dpi(10)
theme.hotkeys_font = "DroidSansM Nerd Font Mono 8"


-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.fg_normal, theme.black
)

theme.systray_icon_spacing = dpi(8)
theme.bg_systray = theme.bg_light

return theme
