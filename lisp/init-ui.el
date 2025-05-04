;;; init-ui.el --- UI and Visual Tweaks -*- lexical-binding: t; -*-

;; Font
(set-face-attribute 'default nil
                    :family "Aporetic Sans Mono"
                    :height 140)

;; Theme
(load-theme 'modus-operandi t)

;; Modeline
(use-package spaceline
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

(display-time-mode 1)
(size-indication-mode 1)

(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3
        which-key-popup-type 'side-window))

;; remember cursor position
(save-place-mode 1)

;; Quality of life
(setq inhibit-default-init t
      inhibit-startup-echo-area-message t
      inhibit-startup-screen t
      initial-scratch-message nil)
(show-paren-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode)
(column-number-mode)
(set-fringe-mode 0)

;; Disable UI chrome
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)

;; Easy resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(provide 'init-ui)
