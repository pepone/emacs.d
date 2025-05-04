;;; init-windowing.el --- Better window management -*- lexical-binding: t; -*-

(use-package ace-window
  :init
  ;; Replace `other-window` with `ace-window`
  (global-set-key [remap other-window] 'ace-window)
  :custom-face
  (aw-leading-char-face
   ((t (:inherit ace-jump-face-foreground :height 3.0))))
  )

(provide 'init-windowing)
