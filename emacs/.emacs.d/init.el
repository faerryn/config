;; Self-compiling `init.el'
(let ((init_el (expand-file-name "init.el" user-emacs-directory)))
  (if (file-newer-than-file-p
       init_el
       (expand-file-name "init.elc" user-emacs-directory))
      (byte-compile-file init_el t))
  (progn
    ;; No frills
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (tooltip-mode -1)
    (setq inhibit-splash-screen t)
    (setq auto-save-default nil)
    (setq backup-inhibited t)
    (setq create-lockfiles nil)
    ;; Silent compilation warnings
    (setq byte-compile-warnings nil)
    (require 'warnings)
    (setq display-warning-minimum-level :error)
    ;; Load packages
    (setq load-prefer-newer t)
    (let ((default-directory
	    (expand-file-name "lisp" user-emacs-directory)))
      (normal-top-level-add-subdirs-to-load-path))
    ;; Load (and recompile) `personal.org'
    (let ((personal.org
	   (expand-file-name "personal.org" user-emacs-directory)))
      (if (file-newer-than-file-p
	   personal.org
	   (expand-file-name "personal.elc" user-emacs-directory))
	  (org-babel-load-file personal.org t)
	(load (expand-file-name "personal" user-emacs-directory))))))
