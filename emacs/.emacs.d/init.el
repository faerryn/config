;; Performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; No frills
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-splash-screen t)
(setq auto-save-default nil)
(setq backup-inhibited t)
(setq create-lockfiles nil)

;; No safe-to-ignore warnings
(setq load-prefer-newer t)

;; Get packages.el, melpa, and use-packages up and running
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Tangle and load `personal.org'
(let ((personal-org
       (expand-file-name "personal.org" user-emacs-directory))
      (personal-el
       (expand-file-name "personal.el" user-emacs-directory)))
  (when (file-newer-than-file-p
	 personal-org
	 personal-el)
    (require 'ob-tangle)
    (org-babel-tangle-file personal-org personal-el)))
(load (expand-file-name "personal" user-emacs-directory))

;; Custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file :noerror)
