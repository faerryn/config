;; Self-compiling `init.el'
(let ((init_el (expand-file-name "init.el" user-emacs-directory)))
  (if (file-newer-than-file-p
	init_el
	(expand-file-name "init.elc" user-emacs-directory))
    (byte-compile-file init_el t))
  (progn
    ;; Load packages
    (setq load-prefer-newer t)
    (let ((default-directory (expand-file-name "lisp" user-emacs-directory)))
      (normal-top-level-add-subdirs-to-load-path))
    ;; Load (and recompile) `emacs.org'
    (let ((emacs_org (expand-file-name "emacs.org" user-emacs-directory)))
      (if (file-newer-than-file-p
	    emacs_org
	    (expand-file-name "emacs.elc" user-emacs-directory))
	(org-babel-load-file emacs_org t)
	(load (expand-file-name "emacs" user-emacs-directory))))))
