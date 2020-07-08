;; Clean UI
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-splash-screen t)
(setq use-dialog-box nil)

;; Load packages
(setq load-prefer-newer t)
(let ((default-directory (concat user-emacs-directory "lisp")))
  (normal-top-level-add-subdirs-to-load-path))

;; Gruvbox
(add-to-list 'custom-theme-load-path
	     (concat user-emacs-directory "lisp/gruvbox"))
(load-theme 'gruvbox t)

;; Undo-tree
(setq auto-save-default nil)
(setq backup-inhibited t)
(setq undo-tree-auto-save-history t)
(setq undo-tree-history-directory-alist
      `(("." . ,(concat user-emacs-directory "undo-tree"))))
(require 'undo-tree)

;; Evil
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode +1)

(require 'evil-collection)
(evil-collection-init)

(require 'evil-surround)
(global-evil-surround-mode +1)

(require 'evil-numbers)
(define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)

(require 'evil-commentary)
(evil-commentary-mode)

(require 'evil-matchit)
(global-evil-matchit-mode +1)

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
	       (concat user-emacs-directory "lisp/magit/magit/Documentation")))

(require 'evil-magit)

;; Org
(require 'org)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(require 'org-evil)

;; Ivy
(require 'ivy)
(require 'counsel)
(require 'swiper)

(ivy-mode +1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-c C-r") 'ivy-resume)

(counsel-mode +1)

(global-set-key "\C-s" 'swiper)

;; Flycheck
(require 'flycheck)
(global-flycheck-mode +1)

;; Projectile
(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Package compilation
(defun compile-packages ()
  "This command byte-compiles every ‘.el’ file in directories in 'load-path' (but not their subdirectories).  A file needs recompilation if a ‘.elc’ file exists but is older than the ‘.el’ file.  When a ‘.el’ file has no corresponding ‘.elc’ file, it compiles them."
  (interactive)
  (dolist (path load-path)
    (when (and (file-directory-p path) (file-writable-p path))
      (dolist (file (directory-files path t "\.el$" t))
	(byte-recompile-file file nil 0)))))


;; Mouse scroll speed
(setq mouse-wheel-scroll-amount '(1))

;; Daemon
(when (daemonp) (server-start))
