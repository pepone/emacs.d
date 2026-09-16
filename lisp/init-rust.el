;;; init-rust.el --- Rust development -*- lexical-binding: t; -*-

;; Requires rustup components: rust-analyzer, rust-src, rustfmt, and clippy.
;; treesit-auto installs the Rust and TOML grammars when needed.

(require 'compile)

(defgroup my/rust nil
  "Personal Rust development settings."
  :group 'languages)

(defcustom my/rust-format-on-save t
  "Whether to format Rust buffers on save when Eglot is connected."
  :type 'boolean
  :group 'my/rust)
(make-variable-buffer-local 'my/rust-format-on-save)
(put 'my/rust-format-on-save 'safe-local-variable #'booleanp)

(defun my/rust-format-before-save ()
  "Format this Rust buffer if enabled and Eglot is managing it."
  (when (and my/rust-format-on-save (eglot-managed-p))
    (eglot-format-buffer)))

(defvar my/rust-cargo-history nil
  "History of Cargo compilation commands.")

(defun my/rust-cargo (command)
  "Run COMMAND in a compilation buffer from the nearest Cargo manifest.
Choose a common Cargo command or enter one with custom arguments.
Use `recompile' to repeat it and `next-error' to visit diagnostics."
  (interactive
   (list (completing-read
          "Cargo command: "
          '("cargo check --message-format=short"
            "cargo build --message-format=short"
            "cargo test --message-format=short"
            "cargo run --message-format=short"
            "cargo clippy --message-format=short")
          nil nil nil 'my/rust-cargo-history
          "cargo check --message-format=short")))
  (let ((default-directory
         (or (locate-dominating-file default-directory "Cargo.toml")
             (user-error "No Cargo.toml found above this buffer")))
        (process-environment (cons "CARGO_TERM_COLOR=never" process-environment)))
    (compile command)))

(defun my/rust-setup ()
  "Configure local Rust editing and save behavior."
  (setq-local indent-tabs-mode nil)
  (setq-local compile-command "cargo check --message-format=short")
  (add-hook 'before-save-hook #'my/rust-format-before-save nil t))

(use-package rust-ts-mode
  :ensure nil
  :hook (rust-ts-mode . my/rust-setup)
  :bind (:map rust-ts-mode-map
              ("C-c C-c" . my/rust-cargo)
              ("C-c C-f" . eglot-format-buffer)
              ("C-c C-a" . eglot-code-actions)
              ("C-c C-r" . eglot-rename)
              ("C-c C-i" . eglot-inlay-hints-mode)
              ("C-c C-d" . flymake-show-buffer-diagnostics)))

(use-package eglot
  :ensure nil
  :hook (rust-ts-mode . eglot-ensure)
  :config
  ;; Eglot supplies Company completion, Flymake diagnostics, Eldoc, and xref.
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) .
                 ("rust-analyzer"
                  :initializationOptions (:check (:command "clippy"))))))

;; The built-in mode is also usable if a TOML grammar is unavailable.
(use-package conf-mode
  :ensure nil
  :mode ("\\.toml\\'" . conf-toml-mode))

(provide 'init-rust)
;;; init-rust.el ends here
