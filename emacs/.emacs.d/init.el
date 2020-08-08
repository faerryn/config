(let ((gc-cons-threshold most-positive-fixnum) ; No GC during init
      (file-name-handler-alist nil)	       ; Faster loading of files
      (load-prefer-newer t)		       ; Load new .el over old .elc
      (vc-follow-symlinks t)		       ; Follow stow's symlinks
      (init-org (expand-file-name "init.org" user-emacs-directory))
      (tangled-el (expand-file-name "tangled.el" user-emacs-directory)))
  (if (file-newer-than-file-p init-org tangled-el)
      (progn
	(require 'ob-tangle)
	(org-babel-tangle-file init-org tangled-el "emacs-lisp")
	(byte-compile-file tangled-el t))
    (load tangled-el)))
