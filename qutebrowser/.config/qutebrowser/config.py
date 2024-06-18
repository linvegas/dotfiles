import os

config.load_autoconfig()

# Color Theme (Onedark)
THEME_BG = "#1f2329"
THEME_L_BG = "#282c34"
THEME_LL_BG = "#30363f"
THEME_LLL_BG = "#323641"
THEME_FG = "#a0a8b7"
THEME_GREY = "#535965"
THEME_L_GREY = "#7a818e"
THEME_BLACK = "#0e1013"
THEME_PURPLE = "#bf68d9"
THEME_GREEN = "#8ebd6b"
THEME_YELLOW = "#e2b86b"
THEME_D_YELLOW = "#835d1a"
THEME_ORANGE = "#cc9057"
THEME_RED = "#e55561"
THEME_BLUE = "#4fa6ed"
THEME_D_BLUE = "#61afef"

# Startpage
c.url.start_pages = f"file://{os.getenv("HOME")}/.config/qutebrowser/index.html"

# Hints
c.hints.chars = "asdghjkl"
c.colors.hints.bg = THEME_YELLOW
c.hints.border = f"1px solid {THEME_D_YELLOW}"

# Webpage
c.colors.webpage.bg = THEME_BG
c.colors.webpage.preferred_color_scheme = "dark"

# Tabs
c.colors.tabs.bar.bg = THEME_BG
c.colors.tabs.even.bg = THEME_BG
c.colors.tabs.odd.bg = THEME_BG
c.colors.tabs.even.fg = THEME_FG
c.colors.tabs.odd.fg = THEME_FG
c.colors.tabs.selected.even.bg = THEME_PURPLE
c.colors.tabs.selected.odd.bg = THEME_PURPLE
c.colors.tabs.selected.even.fg = THEME_BG
c.colors.tabs.selected.odd.fg = THEME_BG

c.tabs.padding = {"top": 3, "right": 3, "bottom": 3, "left": 3}
c.tabs.select_on_remove = "last-used"

# Statusbar
c.colors.statusbar.normal.bg = THEME_BLACK
c.colors.statusbar.normal.fg = THEME_FG
c.colors.statusbar.progress.bg = THEME_BLUE
c.colors.statusbar.url.fg = THEME_GREEN
c.colors.statusbar.url.success.http.fg = THEME_GREEN
c.colors.statusbar.url.success.https.fg = THEME_GREEN
c.colors.statusbar.insert.bg = THEME_GREEN
c.colors.statusbar.insert.fg = THEME_BLACK
c.colors.statusbar.caret.bg = THEME_BLUE
c.colors.statusbar.caret.fg = THEME_BLACK
c.colors.statusbar.caret.selection.bg = THEME_D_BLUE
c.colors.statusbar.caret.selection.fg = THEME_BLACK

c.statusbar.show = "always"
c.statusbar.padding = {"top": 3, "right": 3, "bottom": 3, "left": 3}

# Completion
c.colors.completion.fg = [THEME_FG, THEME_BLUE, THEME_ORANGE]
c.colors.completion.odd.bg = THEME_BG
c.colors.completion.even.bg = THEME_L_BG
c.colors.completion.match.fg = THEME_RED
c.colors.completion.category.bg = THEME_GREY
c.colors.completion.category.fg = "white"
c.colors.completion.scrollbar.bg = THEME_BLACK
c.colors.completion.scrollbar.fg = THEME_GREY
c.colors.completion.item.selected.bg = THEME_BLUE
c.colors.completion.item.selected.fg = THEME_BLACK
c.colors.completion.item.selected.match.fg = THEME_D_YELLOW
c.colors.completion.item.selected.border.top = THEME_BLACK
c.colors.completion.item.selected.border.bottom = THEME_BLACK

# Font
c.fonts.default_size = "12pt"
