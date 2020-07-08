;; Load packages
(setq load-prefer-newer t)
(let ((default-directory (concat user-emacs-directory "lisp")))
  (normal-top-level-add-subdirs-to-load-path))

;; Org
(require 'org)
(org-babel-load-file (concat user-emacs-directory "emacs.org") t)
