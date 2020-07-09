;; Self-compiling `init.el'
(let ((init_el (expand-file-name "init.el" user-emacs-directory)))
  (if (file-newer-than-file-p
       init_el
       (expand-file-name "init.elc" user-emacs-directory))
      (byte-compile-file init_el t))
  (progn
    ;; Load packages
    (setq load-prefer-newer t)
    (let ((default-directory
	    (expand-file-name "lisp" user-emacs-directory)))
      (normal-top-level-add-subdirs-to-load-path))
    ;; Load (and recompile) `personal.org'
    (let ((personal.org (expand-file-name "personal.org" user-emacs-directory)))
      (if (file-newer-than-file-p
	   personal.org
	   (expand-file-name "personal.elc" user-emacs-directory))
	  (org-babel-load-file personal.org t)
	(load (expand-file-name "personal" user-emacs-directory))))))
