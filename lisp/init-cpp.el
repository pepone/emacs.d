;;; init-cpp.el --- C and C++ development -*- lexical-binding: t; -*-

(defun my/c++-setup ()
  "Use Stroustrup indentation in traditional C++ buffers."
  (c-set-style "stroustrup")
  (setq-local c-basic-offset 4))

(use-package cc-mode
  :ensure nil
  :hook (c++-mode . my/c++-setup))

(use-package c-ts-mode
  :ensure nil
  :defer t
  :custom
  (c-ts-mode-indent-offset 4)
  (c-ts-mode-indent-style 'bsd))

(use-package clang-format
  :commands (clang-format-region clang-format-buffer))

(defun my/c-family-format-before-save ()
  "Format with clang-format when both the executable and package are present."
  (when (and (executable-find "clang-format")
             (require 'clang-format nil t))
    (clang-format-buffer)))

(defun my/c-family-setup ()
  "Configure formatting and start clangd when it is installed."
  (add-hook 'before-save-hook #'my/c-family-format-before-save nil t)
  (when (executable-find "clangd")
    (eglot-ensure)))

(use-package eglot
  :ensure nil
  :commands eglot-ensure)

(dolist (hook '(c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook))
  (add-hook hook #'my/c-family-setup))

(provide 'init-cpp)
;;; init-cpp.el ends here
