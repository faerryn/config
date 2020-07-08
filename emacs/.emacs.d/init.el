;; Load packages
(setq load-prefer-newer t)
(let ((default-directory (expand-file-name "lisp" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))

;; Org
(require 'org)
(org-babel-load-file (expand-file-name "emacs.org" user-emacs-directory))
