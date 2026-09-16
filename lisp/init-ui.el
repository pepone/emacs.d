;;; init-ui.el --- UI and Visual Tweaks -*- lexical-binding: t; -*-

;; Frame chrome and the default font are set in early-init.el.

;; Theme: modus, with a toggle between light and dark.  Options must be
;; set before the theme is loaded.
(setq modus-themes-to-toggle '(modus-operandi modus-vivendi)
      modus-themes-mixed-fonts t)
(load-theme 'modus-operandi t)
(global-set-key (kbd "<f5>") #'modus-themes-toggle)

;; Proportional font for prose in Org and Markdown; code, tables and
;; blocks stay monospaced through modus-themes-mixed-fonts.
(set-face-attribute 'variable-pitch nil :family "Aporetic Serif")

;; Mode line: the stock one, compacted only when it overflows, with a
;; clock that omits the load average.
(setq mode-line-compact 'long
      display-time-default-load-average nil)
(display-time-mode 1)
(size-indication-mode 1)
(line-number-mode 1)
(column-number-mode 1)

(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3
        which-key-popup-type 'side-window))

;; Remember cursor positions and window layouts (C-c <left> undoes a
;; layout change).
(save-place-mode 1)
(winner-mode 1)

;; Startup
(setq inhibit-default-init t
      inhibit-startup-screen t
      initial-scratch-message nil)

;; Prompts stay in the minibuffer and take y or n.
(setq use-short-answers t
      use-dialog-box nil)

;; Editing feedback
(show-paren-mode 1)
(setq show-paren-context-when-offscreen 'overlay)
(blink-cursor-mode -1)
(fringe-mode '(8 . 0))   ; left fringe only, for Flymake and Eglot marks

;; Scrolling and mouse
(pixel-scroll-precision-mode 1)
(context-menu-mode 1)

;; Easy resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(provide 'init-ui)
;;; init-ui.el ends here
