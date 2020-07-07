;; Clean UI
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(setq tooltip-use-echo-area t)

;; Daemon
(server-start) 

;; Load packages
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Evil
(setq evil-want-C-u-scroll t)
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

;; Magit
(require 'magit)
(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/lisp/magit/magit/Documentation/"))

(require 'evil-magit)

;; Org
(require 'org)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(require 'org-evil)

;; Aesthetics
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'gruvbox t)
