(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq frame-resize-pixelwise t)
(set-default 'truncate-lines t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq c-basic-offset 4)

(global-display-line-numbers-mode t)

;; (load-theme 'modus-vivendi t)
(add-to-list 'custom-theme-load-path "~/.config/emacs/atom-one-dark-theme.el")
(load-theme 'atom-one-dark t)

(set-frame-font "DroidSansM Nerd Font Mono 13" nil t)

(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))
(setq auto-save-file-name-transforms `((".*" "~/.local/share/emacs/auto-save" t)))
(setq eshell-directory-name "~/.local/share/emacs/eshell")

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'typescript-mode)
  (package-install 'typescript-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(typescript-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
