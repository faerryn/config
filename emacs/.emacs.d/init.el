;; Clean UI
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;; Load packages
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Evil
(require 'evil)
(evil-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'evil-commentary)
(evil-commentary-mode)

;; Aesthetics
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'gruvbox t)
