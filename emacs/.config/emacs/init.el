(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'wombat t)

(set-frame-font "DroidSansM Nerd Font Mono 13" nil t)

(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))
(setq eshell-directory-name "~/.local/share/emacs/eshell")
