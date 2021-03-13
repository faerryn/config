;; Disable Unwanted Features
(setq-default
 make-backup-files nil
 package-enable-at-startup nil)
(auto-save-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Tangle init.org
(let ((init.org (expand-file-name "init.org" user-emacs-directory))
      (init.el (expand-file-name "init.el" user-emacs-directory)))
  (if (file-newer-than-file-p init.org init.el)
      (progn
	(require 'ob-tangle)
	(org-babel-tangle-file init.org init.el "emacs-lisp"))))
