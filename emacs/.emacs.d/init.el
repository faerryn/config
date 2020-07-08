;; Load packages
(setq load-prefer-newer t)
(let ((default-directory (expand-file-name "lisp" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))

;; Load (and recompile) `emacs.org'
(let ((emacs_loadfile (expand-file-name "emacs" user-emacs-directory))
      (emacs_org (expand-file-name "emacs.org" user-emacs-directory)))
  (if (file-newer-than-file-p emacs_org
			      (emacs_elc (concat emacs_loadfile ".elc")))
      (org-babel-load-file emacs_org t)
    (load emacs_loadfile))))

;; Recompile `init.el'
(byte-recompile-file
 (expand-file-name "init.el" user-emacs-directory) nil 0)
