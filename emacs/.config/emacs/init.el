;; No GC during init
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook (lambda () (setq gc-cons-threshold 800000)))

;; Follow symlink (since tangled.el will be in a symlinked folder)
(setq vc-follow-symlinks t)

;; Tangle and load `init.org'
(let ((init-org (expand-file-name "init.org" user-emacs-directory))
      (tangled-el (expand-file-name "tangled.el" user-emacs-directory))
      (tangled-elc (expand-file-name "tangled.elc" user-emacs-directory)))
  (when (file-newer-than-file-p init-org tangled-el)
    (require 'ob-tangle)
    (org-babel-tangle-file init-org tangled-el))
  (when (file-newer-than-file-p tangled-el tangled-elc)
    (byte-compile-file tangled-el))
  (load tangled-elc))
