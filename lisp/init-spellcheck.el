;;; init-spellcheck.el --- Spell Checker Setup -*- lexical-binding: t; -*-

(use-package flyspell
  :ensure nil
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :config
  (setq ispell-dictionary "english"))

(provide 'init-spellcheck)
