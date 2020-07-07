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

(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(require 'evil-commentary)
(evil-commentary-mode)

(require 'evil-matchit)
(global-evil-matchit-mode 1)

(require 'evil-exchange)
(evil-exchange-install)

(require 'evil-textobj-column)
(define-key evil-inner-text-objects-map "c" 'evil-textobj-column-word)
(define-key evil-inner-text-objects-map "C" 'evil-textobj-column-WORD)

;; Aesthetics
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'gruvbox t)
