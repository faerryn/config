;; No GC during init
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

;; No frills
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-splash-screen t)

;; No weird files
(setq auto-save-default nil)
(setq backup-inhibited t)
(setq create-lockfiles nil)

;; Get packages.el, melpa, and use-packages up and running
(setq load-prefer-newer t)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Tangle and load `init.org'
(let ((init-org (expand-file-name "init.org" user-emacs-directory))
      (tangled-el (expand-file-name "tangled.el" user-emacs-directory)))
  (when (file-newer-than-file-p init-org tangled-el)
    (require 'ob-tangle)
    (org-babel-tangle-file init-org tangled-el))
  (load tangled-el))

;; `custom.el'
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file :noerror)
