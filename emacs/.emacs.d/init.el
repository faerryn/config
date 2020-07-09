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
(setq byte-compile-warnings nil)
;; `init.el' self-compile
(setq load-prefer-newer t)
(let ((init-el (expand-file-name "init.el" user-emacs-directory)))
  (if (file-newer-than-file-p
       init-el
       (expand-file-name "init.elc" user-emacs-directory))
      (byte-compile-file init-el t)
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
    ;; Evil-collection shenanigans
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    ;; Load (and recompile) `personal.org'
    (let ((personal-org
	   (expand-file-name "personal.org" user-emacs-directory))
	  (personal-el
	   (expand-file-name "personal.el" user-emacs-directory)))
      (when (file-newer-than-file-p
	     personal-org
	     personal-el)
	(require 'ob-tangle)
	(org-babel-tangle-file personal-org personal-el))
      (when (file-newer-than-file-p
	     personal-el
	     (expand-file-name "personal.elc" user-emacs-directory))
	(byte-compile-file personal-el)))
    (load (expand-file-name "personal" user-emacs-directory))
    ;; Custom file
    (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
    (load custom-file :noerror)))
