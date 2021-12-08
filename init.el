;;; init --- Emacs customizations

;;; Commentary:

;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
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

;; Set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)
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

(use-package spacemacs-common
  :ensure spacemacs-theme
  :config (load-theme 'spacemacs-dark t))
(set-frame-font "Inconsolata 18")

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
  (setq markdown-command "pandoc")
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

(use-package paredit
  :ensure t
  :hook ((lisp-mode inferior-lisp emacs-lisp-mode) . paredit-mode))

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

;;(use-package password-store
;;  :ensure t
;;  :bind
;;  (("C-c p" . password-store-copy)))

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

(use-package rust-mode
  :ensure t
  :defines lsp-rust-server
  :mode ("\\.rs\\'" . rust-mode)
  :config
  (with-eval-after-load 'lsp-mode
    (when (executable-find "rust-anlyzer")
      (setq lsp-rust-server 'rust-analyzer)))
  :custom
  (rust-format-on-save (executable-find "rustfmt")))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode)
  :diminish cargo-minor-mode)

(use-package go-mode
  :mode "\\.go"
  :ensure t)

(use-package lsp-mode
  :ensure t
  :hook
  ((go-mode csharp-mode rust-mode) . lsp)
  (before-save . lsp-format-buffer)
  (before-save . lsp-organize-imports)
  :custom
  (lsp-diagnostic-package :flycheck)
  (lsp-prefer-capf t)
  :config
  (lsp-enable-which-key-integration t)
  :bind (:map company-active-map
              ("C-p" . company-select-previous)
              ("C-n" . company-select-next)
              ("C-j" . company-complete-selection)))

(use-package lsp-ivy
  :ensure t
  :commands (lsp-ivy-workspace-symbol lsp-ivy-global-workspace-symbol))

(use-package yaml-mode
  :ensure t
  :mode "\\.yml\\'")

(use-package ws-butler
  :ensure t
  :hook (prog-mode . ws-butler-mode))

;; Clojure

(use-package clojure-mode
  :ensure t
  :commands clojure-mode
  :config (add-hook 'clojure-mode-hook 'paredit-mode))

(use-package clojure-mode-extra-font-locking
  :ensure t
  :after clojure-mode)

(use-package cider
  :ensure t
  :commands cider-mode
  :config
  (setq nrepl-popup-stacktraces nil)
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode))

(use-package flycheck-clojure
  :ensure t
  :commands clojure-mode
  :config
  (flycheck-clojure-set))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/knowledge"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n o" . org-id-get-create)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n a" . org-roam-alias-add)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :init
  (setq org-roam-v2-ack t)
  :config
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(add-hook 'org-mode-hook 'org-roam-db-autosync-mode)

(require 'org)
(define-key org-mode-map (kbd "M-c &") 'org-mark-ring-goto)
(define-key org-mode-map (kbd "M-c %") 'org-mark-ring-push)

(provide 'init)

;;; init.el ends here
