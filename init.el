;;; init --- Emacs customizations

;;; Commentary:

;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq inhibit-default-init t
      inhibit-startup-echo-area-message t
      inhibit-startup-screen t
      initial-scratch-message nil)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode)
(column-number-mode)
(set-fringe-mode 0)

;; remember cursor position
(save-place-mode 1)

;; Easy resize windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(global-set-key (kbd "C-c w") 'whitespace-mode)

(set-language-environment "UTF-8")

(use-package exec-path-from-shell
  :ensure t
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package ace-popup-menu
  :ensure t
  :config (ace-popup-menu-mode 1))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)))
  :ensure t)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; Set appearance of a tab that is represented by 8 spaces
(setq-default tab-width 8)
(setq-default c-basic-offset 4)
(c-set-offset 'defun-block-intro 4)
(c-set-offset 'statement-block-intro 4)
(c-set-offset 'substatement-open 0)
(c-set-offset 'comment-intro 0)
(c-set-offset 'func-decl-cont 0)
(setq-default nxml-child-indent 4)
(setq-default nxml-attribute-indent 4)
(setq-default ruby-indent-level 4)

;; Reload buffer bind to f5
(global-set-key (kbd "<f5>") 'revert-buffer)

;; Enter full screen mode f11
(defun toggle-fullscreen ()
  "Toggle full screen on X11."
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))
(global-set-key [f11] 'toggle-fullscreen)

;; which key
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; Theme configuration
(use-package dracula-theme
  :ensure t
  :init
  (load-theme 'dracula t))

(set-frame-font "Inconsolata 14")

(use-package multiple-cursors
  :ensure t
  :bind
  (("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . 'mc/mark-all-like-this)))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

;; Replace list buffers with Ibuffer
(use-package ibuffer
  :ensure t
  :bind ("C-x C-b" . ibuffer)
  :init
  (setq ibuffer-formats
	'((mark modified read-only " "
		(name 18 18 :left :elide)
		" "
		(mode 16 16 :left :elide)
		" "
		filename-and-process))))

;; Group buffers by version-control repository
(use-package ibuffer-vc
  :ensure t
  :init
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-vc-set-filter-groups-by-vc-root)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

(use-package column-enforce-mode
  :ensure t
  :config (setq column-enforce-column 120)
  :init (global-column-enforce-mode t)
  :diminish column-enforce-mode)

;; replace ohter-window with ace-window
(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 3.0))))))

(use-package flyspell
  :ensure t
  :config (setq ispell-program-name "aspell"))

;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :init
  (setq markdown-command "multimarkdown")
  (add-hook 'markdown-mode-hook 'flyspell-mode))

;; Magit
(use-package magit
  :ensure t
  :bind
  (("C-x g" . magit-status))
  :config
  (setq git-commit-setup-hook '(git-commit-turn-on-flyspell)))

(use-package recentf
  :config
  (setq recentf-max-saved-items 2000)
  (setq recentf-auto-cleanup 'never)
  (setq recentf-exclude '("**/elpa/**" "/tmp" "/ssh:" "**/*.*~" "**/##*.*##" "/vagrant:" "COMMIT_EDITMSG"))
  (recentf-mode 1))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (setq flycheck-emacs-lisp-load-path 'inherit))

(use-package package-lint
  :ensure t)

(use-package flycheck-package
  :ensure t
  :init
  (flycheck-package-setup)
  :defer t)

(use-package vagrant
  :ensure t
  :bind
  (("C-c U" . vagrant-up)
   ("C-c H" . vagrant-halt)))

(use-package vagrant-tramp
  :ensure t)

;; Ivy completion framework with Counsel and Swipter enhacements
(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :bind
  (("C-c r" . counsel-recentf)
   ("C-c C-r" . ivy-resume)
   ("<f6>" . ivy-resume)
   ("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   ("C-x C-f" . counsel-find-file)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c k" . counsel-rg)
   ("C-s" . counsel-grep-or-swiper))
  :config
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    (setq counsel-git-grep-cmd-default "git --no-pager grep --full-name -n --no-color -i -e \"%s\"")
    (setq counsel-grep-base-command "rg -i -M 120 --no-heading --line-number --color never '%s' %s"))

(use-package org
  :ensure t
  :config
  (add-to-list 'org-file-apps '(directory . emacs)))

(use-package csharp-mode
  :ensure t
  :mode "\\.cs\\'")

(use-package clang-format
  :ensure t
  :config
  (global-set-key (kbd "C-c i") 'clang-format-region)
  (global-set-key (kbd "C-c u") 'clang-format-buffer))

(use-package groovy-mode
  :ensure t
  :mode (("\\.gradle\\'" . groovy-mode)))

(use-package gradle-mode
  :ensure t)

(use-package go-mode
  :ensure t
  :mode ("\\.go\\'" . go-mode))

(use-package haskell-mode
  :config
  :ensure t
  :mode ("\\.hs\\'" . haskell-mode))

(use-package intero
  :ensure t
  :init (add-hook 'haskell-mode-hook 'intero-mode))

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-fancy slime-banner)))

(use-package make-mode
  :mode ("\\Make.rules\\'" . makefile-mode)
  :mode ("\\Make.*.rules\\'" . makefile-mode)
  :mode ("\\Make.rules.*\\'" . makefile-mode)
  :mode ("\\Makefile.mk\\'" . makefile-mode))

;;
;; TypeScript
;;
(use-package tide
    :ensure t
    :config
    (add-hook 'typescript-mode-hook #'setup-tide-mode))

;;
;; PHP
;;
(use-package php-mode
  :ensure t
  :mode "\\.php$")

(use-package password-store
  :ensure t
  :bind
  (("C-c p" . password-store-copy)))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs (append yas-snippet-dirs '("~/.emacs.d/snippets"))) ;; Personal snippets
  (yas-global-mode 1))

(use-package swift-mode
  :if (eq system-type "darwin")
  :ensure t
  :mode ("\\.swift\\'" . swift-mode))

(use-package flycheck-swift
  :ensure t
  :if (eq system-type "darwin")
  :after (flycheck swift-mode)
  :config (progn (add-to-list 'flycheck-checkers 'swift)))

;; Clojure
(use-package clojure-mode
  :ensure t
  :mode
  (("\\.clj\\'" . clojure-mode)
   ("\\.cljs.*\\'" . clojure-mode)))

(use-package cider
  :ensure t
  :after clojure-mode)

(use-package flycheck-clojure
  :ensure t
  :after (flycheck clojure))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(provide 'init)

;;; init.el ends here
