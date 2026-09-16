;;; early-init.el --- Frame setup before the first frame -*- lexical-binding: t; -*-

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
