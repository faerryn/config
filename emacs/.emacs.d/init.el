;; No GC during init
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook (lambda () (setq-default gc-cons-threshold 800000)))

;; Load newer lisps
(setq-default load-prefer-newer t)

;; Follow symlink
(setq-default vc-follow-symlinks t)

;; Tangle and load `init.org'
(let ((init-org (expand-file-name "init.org" user-emacs-directory))
      (tangled-el (expand-file-name "tangled.el" user-emacs-directory)))
  (when (file-newer-than-file-p init-org tangled-el)
    (require 'ob-tangle)
    (org-babel-tangle-file init-org tangled-el emacs-lisp))
  (load tangled-el))
