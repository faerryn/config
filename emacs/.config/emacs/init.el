(let ((gc-cons-threshold most-positive-fixnum) ; No GC during init
      (file-name-handler-alist nil)	       ; Faster loading of files
      (vc-follow-symlinks t)		       ; Follow stow's symlinks
      (init-org (expand-file-name "init.org" user-emacs-directory))
      (tangled-el (expand-file-name "tangled.el" user-emacs-directory))
      (tangled-elc (expand-file-name "tangled.elc" user-emacs-directory)))
  (if (file-newer-than-file-p init-org tangled-elc)
      (progn
	(require 'ob-tangle)
	(org-babel-tangle-file init-org tangled-el "emacs-lisp")
	(load-file tangled-el)
	(byte-compile-file tangled-el))
    (load-file tangled-elc)))
