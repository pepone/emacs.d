;;; init-env.el --- Environment Variables Setup -*- lexical-binding: t; -*-

(when (or (daemonp) (memq window-system '(mac ns x pgtk)))
  (use-package exec-path-from-shell
    :config
    (setq exec-path-from-shell-variables '("PATH" "MANPATH" "SSH_AUTH_SOCK")) ;; Optional extra vars
    (exec-path-from-shell-initialize)))

(defun my/check-dependencies ()
  "Report configuration dependencies visible to this Emacs session.
This checks availability only; it does not install or run external tools."
  (interactive)
  (with-help-window "*Emacs dependencies*"
    (princ "External tools visible to Emacs\n\n")
    (dolist (entry `(("git" . "Version control")
                     ("rg" . "Consult search")
                     ("cc" . "Tree-sitter grammar compilation")
                     ("c++" . "Tree-sitter grammar compilation")
                     ("rustup" . "Rust toolchains")
                     ("cargo" . "Rust builds and tests")
                     ("rust-analyzer" . "Rust language server")
                     ("rustfmt" . "Rust formatting")
                     ("clippy-driver" . "Rust linting")
                     ("clangd" . "C/C++ language server")
                     (,(or (bound-and-true-p clang-format-executable)
                           "clang-format-19") . "C/C++ formatting")
                     ("node" . "JavaScript tools")
                     ("typescript-language-server" . "JavaScript/TypeScript language server")
                     ("prettier" . "JavaScript/TypeScript formatting")
                     ("sbcl" . "Common Lisp")
                     ("dot" . "Org-roam graphs")
                     ("pass" . "Password store")))
      (princ (format "%-28s %s\n  %s\n"
                     (car entry) (cdr entry)
                     (or (executable-find (car entry)) "NOT FOUND"))))
    (princ (format "\nSpell checker: %s\n"
                   (or (executable-find "aspell")
                       (executable-find "hunspell")
                       (executable-find "ispell")
                       "NOT FOUND (aspell, hunspell, or ispell)")))
    (princ "\nProject-local tools may still be available outside exec-path.\n")
    (princ "Rustup proxies on PATH do not guarantee the component is installed.\n")
    (princ "\nMissing Emacs packages (install with M-x my/install-packages):\n")
    (require 'init-packages)
    (let ((missing (seq-remove #'package-installed-p my/required-packages)))
      (if missing
          (dolist (package missing) (princ (format "  %s\n" package)))
        (princ "  None\n")))))

(provide 'init-env)
