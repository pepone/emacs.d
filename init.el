 ;;; init.el --- Base Emacs configuration -*- lexical-binding: t; -*-

;; Font
(set-face-attribute 'default nil
                    :family "Aporetic Sans Mono"
                    :height 140)

;; Theme
(load-theme 'modus-operandi t)

;; Package management setup
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not present
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Completion setup: Vertico, Marginalia, Consult
(use-package vertico
  :init
  (vertico-mode)
  :bind
  (:map vertico-map
        ("C-j" . vertico-move-end-of-line-or-insert))
  :init
  (defun vertico-move-end-of-line-or-insert (arg)
    "Move to end of line or insert current candidate.
   ARG lines can be used.

   When only one candidate exists exit input after insert."
    (interactive "p")
    (if (eolp)
        (progn
          (vertico-insert)
          (when (= vertico--total 1)
            (vertico-exit)))
      (move-end-of-line arg))))

;; Convenient path selection
(use-package vertico-directory
  :after vertico
  :ensure nil ;; no need to install, it comes with vertico
  :bind (:map vertico-map
	      ("DEL" . vertico-directory-delete-char)))

(use-package orderless
  :custom
  ;; Activate orderless completion
  (completion-styles '(orderless basic))
  ;; Enable partial completion for file wildcard support
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

;; Recentf setup
(use-package recentf
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 200
        recentf-auto-cleanup 'never))

(use-package spaceline
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

;; Extras to make the modeline richer
(display-time-mode 1)
(size-indication-mode 1)

(use-package consult
  :custom
  ;; Disable preview
  (consult-preview-key nil)
  :bind
  (("C-x b" . 'consult-buffer) ;; Switch buffer, including recentf and bookmarks
   ("M-l"   . 'consult-git-grep) ;; Search inside a project
   ("M-y"   . 'consult-yank-pop) ;; Paste by selecting the kill-ring
   ("C-s"   . 'consult-line)	 ;; Search current buffer, like swiper
   ("C-c j" . 'consult-git-grep) ;; Git grep
   ("C-c k" . 'consult-ripgrep)	 ;; ripgrep
   ("C-c r" . 'consult-recent-file) ;; Recent files
   ))

(use-package embark
  :bind
  (("C-."   . embark-act)         ;; Begin the embark process
   ("C-;"   . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :config
  (use-package embark-consult))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Emacs minibuffer configurations.
(use-package emacs
  :custom
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3) ;; faster popups
  (setq which-key-popup-type 'side-window)) 

;; Spell checker
(use-package flyspell
  :hook ((text-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :config
  (setq ispell-dictionary "english"))

;; Magit
(use-package magit
  :ensure t
  :bind
  (("C-x g" . magit-status))
  :config
  (setq git-commit-setup-hook '(git-commit-turn-on-flyspell)))

;; Common Lisp + Paredit 
(use-package slime
  :config
  (setq inferior-lisp-program "sbcl")) ;; or another Lisp like ecl, ccl, etc.

(use-package paredit
  :hook ((emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode) . paredit-mode))

;; Org Roam for notes
(use-package org-roam
  :custom
  (org-roam-directory (file-truename "~/Documents/knowledge"))
  :config
  (org-roam-db-autosync-mode))

;; Quality of life improvements
(setq inhibit-startup-screen t)
(global-display-line-numbers-mode t)
(column-number-mode t)
(show-paren-mode 1)

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(slice-mode consult marginalia vertico which-key spaceline slime paredit org-roam modus-themes magit lsp-ivy flycheck-package exec-path-from-shell counsel column-enforce-mode ace-window ace-popup-menu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
