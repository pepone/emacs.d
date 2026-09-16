;;; early-init.el --- Frame setup before the first frame -*- lexical-binding: t; -*-

;; Raise the GC threshold during startup and restore the original value even
;; when init.el exits early with an error.
(defvar my/startup-gc-cons-threshold gc-cons-threshold)
(setq gc-cons-threshold most-positive-fixnum)
(defun my/restore-startup-gc ()
  "Restore the garbage collection threshold after startup."
  (setq gc-cons-threshold my/startup-gc-cons-threshold))
(add-hook 'emacs-startup-hook #'my/restore-startup-gc)

;; Frame parameters set here apply to every frame, including ones made
;; by emacsclient, and avoid the toolbar flash and resize on launch.
(setq frame-inhibit-implied-resize t)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(font . "Aporetic Serif Mono-16") default-frame-alist)
;; Keep the mode variables in sync so a later M-x toggle works first time.
(setq tool-bar-mode nil
      menu-bar-mode nil
      scroll-bar-mode nil)

;; Background native compilation should not pop up the Warnings buffer.
(setq native-comp-async-report-warnings-errors 'silent)

;;; early-init.el ends here
