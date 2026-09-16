;;; init-windowing.el --- Better window management -*- lexical-binding: t; -*-

(use-package ace-window
  :init
  ;; Replace `other-window` with `ace-window`
  (global-set-key [remap other-window] 'ace-window)
  :custom-face
  (aw-leading-char-face
   ((t (:inherit ace-jump-face-foreground :height 3.0))))
  )

(defun my/compilation-or-diagnostics-buffer-p (buffer _action)
  "Return non-nil when BUFFER displays compilation or Flymake results."
  (with-current-buffer buffer
    (derived-mode-p 'compilation-mode
                    'flymake-diagnostics-buffer-mode
                    'flymake-project-diagnostics-mode)))

(defun my/help-buffer-p (buffer _action)
  "Return non-nil when BUFFER displays help."
  (with-current-buffer buffer
    (derived-mode-p 'help-mode)))

(add-to-list 'display-buffer-alist
             '(my/compilation-or-diagnostics-buffer-p
               (display-buffer-reuse-window display-buffer-at-bottom)
               (window-height . 0.25)))
(add-to-list 'display-buffer-alist
             '(my/help-buffer-p
               (display-buffer-reuse-window display-buffer-in-side-window)
               (side . right)
               (window-width . 0.4)))

(provide 'init-windowing)
