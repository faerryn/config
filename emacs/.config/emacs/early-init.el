(let ((init_org (expand-file-name "init.org" user-emacs-directory))
      (init_el (expand-file-name "init.el" user-emacs-directory)))
  (if (file-newer-than-file-p init_org init_el)
      (progn
	(require 'ob-tangle)
	(org-babel-tangle-file init_org init_el "emacs-lisp"))))
