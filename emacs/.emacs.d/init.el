(menu-bar-mode -1)
(tool-bar-mode -1)

(add-to-list 'load-path "~/.emacs.d/packages/evil")
(require 'evil)
(evil-mode 1)

(add-to-list 'load-path "~/.emacs.d/packages/dash.el")
(require 'dash)

(add-to-list 'load-path "~/.emacs.d/packages/autothemer")
(require 'autothemer)

(add-to-list 'load-path "~/.emacs.d/packages/emacs-theme-gruvbox")
(require 'gruvbox)
(add-to-list 'custom-theme-load-path "~/.emacs.d/packages/emacs-theme-gruvbox")
(load-theme 'gruvbox t)
