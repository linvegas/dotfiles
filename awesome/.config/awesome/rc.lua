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

muhtextclock = wibox.widget.textclock(" %a %d/%m/%y %H:%M ")
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
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout = wibox.layout.fixed.horizontal,
    }

    s.muhtasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags, -- focused
        buttons = tasklist_buttons,
        widget_template = {
            {
                {
                    {
                        {
                            id     = "icon_role",
                            widget = wibox.widget.imagebox,
                        },
                        left  = dpi(2),
                        right = dpi(6),
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = "text_role",
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                margins = dpi(5),
                widget = wibox.container.margin
            },
            id     = "background_role",
            widget = wibox.container.background,
        }
    }

    s.muhsystray = wibox.widget.systray()

    s.muhwibox = awful.wibar({
        position = "top",
        screen = s,
        bg = theme.black,
    })

    s.muhwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            wibox.layout.margin(muhlauncher, dpi(5),dpi(5),dpi(5),dpi(5)),
            s.muhtaglist,
            layout = wibox.layout.fixed.horizontal,
        },
          -- Middle widgets
        s.muhtasklist,
        { -- Right widgets
            muhtextclock,
            wibox.layout.margin(s.muhsystray, dpi(5),dpi(5),dpi(5),dpi(5)),
            wibox.layout.margin(s.muhlayoutbox, dpi(5),dpi(5), dpi(5), dpi(5)),
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

    awful.titlebar(c, {size = 24}) : setup {
        { -- Left
            {
                awful.titlebar.widget.closebutton    (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.stickybutton   (c),
                layout  = wibox.layout.fixed.horizontal,
                spacing = dpi(4),
            },
            left = dpi(8),
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin,
        },
        { -- Middle
            {
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal,
        },
        { -- Right
            {
                awful.titlebar.widget.iconwidget(c),
                layout = wibox.layout.fixed.horizontal
            },
            right = dpi(8),
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
        expand = "none"
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
