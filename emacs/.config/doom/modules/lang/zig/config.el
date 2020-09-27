;;; ../../config/emacs/.config/doom/lang/zig/config.el -*- lexical-binding: t; -*-

(use-package! zig-mode
  :mode ("\\.zig$" . zig-mode)
  :commands zig-mode zig-run zig-compile zig-build-exe zig-build-lib zig-build-obj zig-test-buffer zig-format-buffer zig-toggle-format-on-save)
