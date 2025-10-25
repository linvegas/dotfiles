(setq custom-file "~/.local/share/emacs/emacs.custom.el")

(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq auto-save-list-file-name "~/.local/share/emacs/auto-save-list")
(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))
(setq eshell-directory-name "~/.local/share/emacs/eshell")
(setq ido-save-directory-list-file "~/.local/share/emacs/ido-last")
(setq package-user-dir "~/.local/share/emacs/elpa")

(ido-mode 1)
(ido-everywhere 1)

(global-display-line-numbers-mode t)
(setq frame-resize-pixelwise t)
(set-default 'truncate-lines t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq c-basic-offset 4)

(load-theme 'wombat t)

(set-face-attribute 'line-number nil :inherit 'default)
(set-face-attribute 'line-number-current-line nil :inherit 'default)

(set-frame-font "DroidSansM Nerd Font Mono 16" nil t)

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

; (unless (package-installed-p 'rust-mode)
;   (package-install 'rust-mode))

(load-file custom-file)
