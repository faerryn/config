;; Disable Unwanted Features
(setq-default
 byte-compile-warnings nil
 make-backup-files nil
 package-enable-at-startup nil)
(auto-save-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Follow Symlinks
(setq-default vc-follow-symlinks t)

;; Disable Garbage Collection
(setq-default gc-cons-threshold most-positive-fixnum)

;; Tangle init.org
(let ((init.org (expand-file-name "init.org" user-emacs-directory))
      (init.el  (expand-file-name "init.el"  user-emacs-directory))
      (init.elc (expand-file-name "init.elc" user-emacs-directory)))
  (unless (file-newer-than-file-p init.el init.org)
    (require 'ob-tangle)
    (org-babel-tangle-file init.org init.el "emacs-lisp"))
  (unless (file-newer-than-file-p init.elc init.el)
    (require 'bytecomp)
    (byte-compile-file init.el)))
