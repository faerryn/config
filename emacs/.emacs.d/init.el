;; No frills
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq inhibit-splash-screen t)
(setq auto-save-default nil)
(setq backup-inhibited t)
(setq create-lockfiles nil)
;; Silent compilation warnings
(setq byte-compile-warnings nil)
(setq display-warning-minimum-level :error)
;; Performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
;; Self-compiling `init.el'
(let ((init_el (expand-file-name "init.el" user-emacs-directory)))
  (when (file-newer-than-file-p
	 init_el
	 (expand-file-name "init.elc" user-emacs-directory))
    (byte-compile-file init_el)))
;; Load packages
(setq load-prefer-newer t)
(let ((lisp-directory
       (expand-file-name "lisp" user-emacs-directory)))
  (mapc (lambda (submodule-directory)
	  (let ((submodule-full-directory
		 (expand-file-name submodule-directory lisp-directory)))
	    (let ((submodule-lisp-subdir
		   (expand-file-name "lisp" submodule-full-directory)))
	      (if (and
		   (file-exists-p submodule-lisp-subdir)
		   (file-directory-p submodule-lisp-subdir))
		  (add-to-list 'load-path submodule-lisp-subdir)
		(add-to-list 'load-path submodule-full-directory)))))
	(split-string
	 (shell-command-to-string
	  (concat "cd " lisp-directory "; git ls-files")))))
;; Load (and recompile) `personal.org'
(let ((personal.org
       (expand-file-name "personal.org" user-emacs-directory)))
  (if (file-newer-than-file-p
       personal.org
       (expand-file-name "personal.elc" user-emacs-directory))
      (org-babel-load-file personal.org t)
    (load (expand-file-name "personal" user-emacs-directory))))
