import os

config.load_autoconfig()

# Startpage
c.url.start_pages = f"file://{os.getenv("HOME")}/.config/qutebrowser/index.html"

# Hints
c.hints.chars = "asdghjkl"
c.colors.hints.bg = "#e2b86b"
c.hints.border = "1px solid #835d1a"

# Webpage
c.colors.webpage.bg = "#1f2329"
c.colors.webpage.preferred_color_scheme = "dark"

# Tabs
c.colors.tabs.bar.bg = "#1f2329"
c.colors.tabs.even.bg = "#1f2329"
c.colors.tabs.odd.bg = "#1f2329"
c.colors.tabs.selected.even.bg = "#bf68d9"
c.colors.tabs.selected.odd.bg = "#bf68d9"
c.colors.tabs.selected.even.fg = "#1f2329"
c.colors.tabs.selected.odd.fg = "#1f2329"

c.tabs.padding = {"top": 3, "right": 3, "bottom": 3, "left": 3}

# Statusbar
c.colors.statusbar.normal.bg = "#0e1013"
c.colors.statusbar.normal.fg = "#a0a8b7"
c.colors.statusbar.progress.bg = "#a0a8b7"
c.colors.statusbar.url.fg = "#8ebd6b"
c.colors.statusbar.url.success.http.fg = "#8ebd6b"
c.colors.statusbar.url.success.https.fg = "#8ebd6b"

c.statusbar.show = "always"
c.statusbar.padding = {"top": 3, "right": 3, "bottom": 3, "left": 3}

# Font
c.fonts.default_size = "12pt"
