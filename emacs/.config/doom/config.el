;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jiang Meng Liao (Faerryn)"
      user-mail-address "alexandre.liao@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 12.0 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "monospace" :size 12.0))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq
 async-shell-command-buffer 'new-buffer
 auth-source-save-behavior nil)

;; This is kinda hacky but it works
(add-to-list
 '+popup--display-buffer-alist
 '("^\\*Async Shell Command\\*\\(<[0-9]+>\\)?$"
   (display-buffer-no-window)))

(add-to-list 'ivy-ignore-buffers "^\\*Async Shell Command\\*\\(<[0-9]+>\\)?$")

(use-package! openwith
  :init
  (setq openwith-associations '(("\\.(?!el)\\'" "xdg-open" (file))))
  :config
  (openwith-mode 1))

(after! eglot
  (setq eglot-server-programs nil)
  (set-eglot-client! 'zig-mode '("zls"))
  (set-eglot-client! 'c-mode '("clangd" "-j=3" "--clang-tidy"))
  (set-eglot-client! 'c++-mode '("clangd" "-j=3" "--clang-tidy")))

(use-package! exwm
  :commands exwm-enable
  :config
  (add-hook! 'exwm-update-class-hook (exwm-workspace-rename-buffer exwm-class-name))
  (map! :map 'exwm-mode-map
        doom-leader-alt-key #'doom/leader
        "M-!" #'shell-command)
  (add-hook!
   'exwm-init-hook
   (call-process "xrdb" nil nil nil "-merge" (expand-file-name "Xresources" (getenv "XDG_CONFIG_HOME")))
   (make-process :name "redshift" :command '("redshift" "-l40.7:-73.9" "-r") :noquery t))
  (add-hook! 'exwm-exit-hook (interrupt-process "redshift")))

(add-to-list 'command-switch-alist '("--exwm" . (lambda (switch) (exwm-enable))))
