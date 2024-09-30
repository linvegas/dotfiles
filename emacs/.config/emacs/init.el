(setq custom-file "~/.local/share/emacs/emacs.custom.el")

(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(ido-mode 1)
(ido-everywhere 1)

(global-display-line-numbers-mode t)
(setq frame-resize-pixelwise t)
(set-default 'truncate-lines t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq c-basic-offset 4)

;; (load-theme 'modus-vivendi t)
(add-to-list 'custom-theme-load-path "~/.config/emacs/atom-one-dark-theme.el")
(load-theme 'atom-one-dark t)

(set-face-attribute 'line-number nil :inherit 'default)
(set-face-attribute 'line-number-current-line nil :inherit 'default)

(set-frame-font "DroidSansM Nerd Font Mono 16" nil t)

(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.local/share/emacs/auto-save" t)))
(setq eshell-directory-name "~/.local/share/emacs/eshell")

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'typescript-mode)
  (package-install 'typescript-mode))
(unless (package-installed-p 'rust-mode)
  (package-install 'rust-mode))

(load-file custom-file)
