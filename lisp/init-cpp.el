;;; init-cpp.el --- C++ Development Setup -*- lexical-binding: t; -*-

;; C++ settings
(use-package cc-mode
  :ensure nil ;; built-in
  :mode ("\\.cpp\\'" "\\.hpp\\'" "\\.c\\'" "\\.h\\'")
  :hook ((c++-mode . my/c++-setup))
  :config
  (defun my/c++-setup ()
    "Custom C++ mode settings."
    (c-set-style "stroustrup") ;; or "linux", "bsd", "gnu", etc.
    (setq c-basic-offset 4)))

;; Clang-Format integration
(use-package clang-format
  :hook ((c-mode c++-mode) . my/clang-format-on-save)
  :commands (clang-format-region clang-format-buffer)
  :config
  (defun my/clang-format-on-save ()
    "Format C/C++ buffers with clang-format on save."
    (add-hook 'before-save-hook #'clang-format-buffer nil t)))

;; Optional: Manual keybinding if you want
;; (global-set-key (kbd "C-c f") #'clang-format-buffer)

(provide 'init-cpp)
