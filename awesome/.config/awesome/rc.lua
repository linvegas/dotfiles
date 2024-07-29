-- pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Autostart programs
awful.spawn.with_shell("setmonitor")
awful.spawn.with_shell("nm-applet")

require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

-- Error handling
require("error")

-- Main vars
vars = {
    terminal   = "alacritty",
    editor     = os.getenv("EDITOR") or "nvim",
    editor_cmd = "alacritty -e nvim",
    modkey     = "Mod4",
}

local theme = require("theme")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

local main = {
    layouts   = require("layouts"),
    tags      = require("tags"),
    keymaps   = require("keymaps"),
    rules     = require("rules"),
}

main.layouts.set()

muhawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", vars.terminal .. " -e man awesome" },
    { "Config", vars.editor_cmd .. " " .. awesome.conffile },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

muhmainmenu = awful.menu({
    items = {
        { "Awesome", muhawesomemenu, beautiful.awesome_icon },
        { "Terminal", vars.terminal }
    }
})

muhlauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = muhmainmenu
})

-- Set the terminal for applications that require it
menubar.utils.terminal = vars.terminal

-- muhtextclock = wibox.widget.textclock("%a %d/%m/%y %H:%M")
muhtextclock = wibox.widget {
    {
        {
            format = "%a %d/%m/%y %H:%M",
            widget = wibox.widget.textclock,
        },
        margins = dpi(6),
        widget = wibox.container.margin,
    },
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, dpi(2))
    end,
    widget = wibox.container.background,
    bg = theme.bg_light,
}

local clock_tooltip = awful.tooltip{delay_show = 0.5}
clock_tooltip:add_to_object(muhtextclock)
muhtextclock:connect_signal("mouse::enter", function()
    awful.spawn.easy_async("cal", function(stdout, _, _, _)
        clock_tooltip.text = stdout
    end)
end)

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ vars.modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ vars.modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(1)
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    s.mypromptbox = awful.widget.prompt()
    s.muhlayoutbox = awful.widget.layoutbox(s)
    s.muhlayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function () awful.layout.inc( 1) end),
        awful.button({}, 3, function () awful.layout.inc(-1) end),
        awful.button({}, 4, function () awful.layout.inc( 1) end),
        awful.button({}, 5, function () awful.layout.inc(-1) end))
    )

    s.muhtaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
        style   = {
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, dpi(2))
            end,
        },
        layout = {
            spacing = dpi(2),
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    id     = "text_role",
                    widget = wibox.widget.textbox,
                },
                widget  = wibox.container.margin,
                left = dpi(5),
                right = dpi(5),
            },
            id     = "background_role",
            widget = wibox.container.background,
        },
    }

    s.muhtasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags, -- focused
        buttons = tasklist_buttons,
        style   = {
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h, dpi(2))
            end,
        },
        layout   = {
            spacing = dpi(2),
            spacing_widget = {
                valign = "center",
                halign = "center",
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        id     = "icon_role",
                        widget = wibox.widget.imagebox,
                    },
                    widget  = wibox.container.margin,
                },
                margins = dpi(2),
                widget = wibox.container.margin,
            },
            id     = "background_role",
            widget = wibox.container.background,
        }
    }

    -- s.muhsystray = wibox.widget.systray()

    s.muhsystray = wibox.widget {
        {
            {
                widget = wibox.widget.systray(),
            },
            margins = dpi(4),
            widget = wibox.container.margin,
        },
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, dpi(2))
        end,
        widget = wibox.container.background,
        bg = theme.bg_light,
    }

    s.muhwibox = awful.wibar({
        position = "bottom",
        screen = s,
        height = dpi(30),
        bg = theme.bg,
    })

    s.muhwibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            wibox.layout.margin(muhlauncher, dpi(4),dpi(4),dpi(8),dpi(8)),
            wibox.layout.margin(s.muhtaglist, dpi(4),dpi(4),dpi(4),dpi(4)),
            -- s.muhtaglist,
            layout = wibox.layout.fixed.horizontal,
        },
          -- Middle widgets
        -- s.muhtasklist,
        wibox.layout.margin(s.muhtasklist, dpi(3),dpi(3),dpi(3),dpi(3)),
        { -- Right widgets
            wibox.layout.margin(muhtextclock, dpi(4),dpi(4),dpi(4),dpi(4)),
            wibox.layout.margin(s.muhsystray, dpi(4),dpi(4),dpi(4),dpi(4)),
            wibox.layout.margin(s.muhlayoutbox, dpi(4),dpi(4), dpi(8), dpi(8)),
            layout = wibox.layout.fixed.horizontal,
        },
    }
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar

    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(23)}) : setup {
        { -- Left
            {
                awful.titlebar.widget.iconwidget(c),
                awful.titlebar.widget.titlewidget(c),
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(8),
            },
            left = dpi(8),
            top = dpi(3),
            bottom = dpi(3),
            widget = wibox.container.margin,
        },
        { -- Middle
            buttons = buttons,
            layout  = wibox.layout.align.horizontal,
        },
        { -- Right
            {
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(6),
            },
            right = dpi(8),
            top = dpi(3),
            bottom = dpi(3),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
        expand = "inside"
    }
end)

-- Turn titlebar on when client is floating
client.connect_signal("property::floating", function(c)
    if c.floating and not c.requests_no_titlebar then
        c.border_width = beautiful.border_width
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
        c.shape = gears.shape.rectangle
    end
end)

-- Turn tilebars on when layout is floating
awful.tag.attached_connect_signal(nil, "property::layout", function (t)
    local float = t.layout.name == "floating"
    for _,c in pairs(t:clients()) do
        c.floating = float
    end
end)

-- Turn tilebars on when spwan client at floating layout
awful.tag.attached_connect_signal(nil, "tagged", function(t, c)
    if t.layout.name == "floating" then
        awful.titlebar.show(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- No borders when rearranging only 1 non-floating client or on max layout
screen.connect_signal("arrange", function (s)
    local float_layout = s.selected_tag.layout.name == "floating"
    local max_layout = s.selected_tag.layout.name == "max"

    for _, c in pairs(s.clients) do
        if (#s.tiled_clients == 1 or max_layout) and not float_layout and not c.floating or c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
            if float_layout or c.floating then c.shape = gears.shape.rounded_rect end
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
