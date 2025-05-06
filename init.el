;;; init.el --- Emacs Configuration -*- lexical-binding: t; -*-

;; Boost startup
(setq gc-cons-threshold most-positive-fixnum)

;; Set custom-file separately to avoid cluttering init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Load submodules
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-packages)
(require 'init-env)
(require 'init-completion)
(require 'init-ui)
(require 'init-windowing)
(require 'init-editing)
(require 'init-auth)
(require 'init-lisp)
(require 'init-org)
(require 'init-vcs)
(require 'init-spellcheck)
(require 'init-treesit)
(require 'init-javascript)

;; Restore GC
(setq gc-cons-threshold 800000)

(provide 'init)
;;; init.el ends here
