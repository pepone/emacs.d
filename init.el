(require 'package)
(setq package-enable-at-startup nil)
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

(tool-bar-mode -1) ;; disable the tool bar
(menu-bar-mode -1) ;; disable the menu bar
(scroll-bar-mode -1) ;; disable scroll bar
(blink-cursor-mode -1)
(line-number-mode)
(column-number-mode)
(set-fringe-mode 0) ;; Disabling fringe (that little column on the left)

(use-package ace-popup-menu
  :ensure t
  :config (ace-popup-menu-mode 1))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1)))
  :ensure t)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

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

;; Reload buffer bind to f5
(global-set-key (kbd "<f5>") 'revert-buffer)

;; Enter full screen mode f11
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
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
(use-package base16-theme
  :ensure t
  :init
  (load-theme 'base16-dracula t))

(set-default-font "Courier Prime Code 12")
(setq-default line-spacing 4)

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

;; Replace list buffers with Ibuffer
(use-package ibuffer
  :ensure nil
  :bind ("C-x C-b" . ibuffer))

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
  (setq recentf-exclude '((expand-file-name "~/.emacs.d/elpa/**")
                          "/tmp" "/ssh:" "**/*.*~" "**/##*.*##" "COMMIT_EDITMSG"))
  (recentf-mode 1))

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

;; ensure environment variables inside Emacs look the same as in the user's shell
;; (use-package exec-path-from-shell
;;  :ensure t
;;  :config
;;  (exec-path-from-shell-initialize))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit zenburn-theme which-key use-package try spacemacs-theme spaceline moe-theme eziam-theme color-theme base16-theme alect-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
