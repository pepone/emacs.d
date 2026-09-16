;;; init-packages-test.el --- Package bootstrap checks -*- lexical-binding: t; -*-

(require 'ert)
(require 'cl-lib)
(require 'package)

;; Load the bootstrap without using the user's installed packages or network.
(setq package-user-dir (make-temp-file "emacs-bootstrap-tests-" t))
(cl-letf (((symbol-function 'package-installed-p) (lambda (&rest _) t)))
  (require 'init-packages))

(ert-deftest my/packages-present-never-contact-archives ()
  (let ((my/required-packages '(one two)))
    (cl-letf (((symbol-function 'package-installed-p) (lambda (_) t))
              ((symbol-function 'package-refresh-contents)
               (lambda () (ert-fail "Unexpected network access")))
              ((symbol-function 'package-install)
               (lambda (_) (ert-fail "Unexpected installation"))))
      ;; Exercise the automatic startup call as well as the interactive helper.
      (load "init-packages" nil t)
      (my/install-packages))))

(ert-deftest my/packages-install-only-missing ()
  (let ((my/required-packages '(one two three))
        (installed '(one))
        (refreshes 0)
        installs)
    (cl-letf (((symbol-function 'package-installed-p)
               (lambda (name) (memq name installed)))
              ((symbol-function 'package-refresh-contents)
               (lambda () (cl-incf refreshes)))
              ((symbol-function 'package-install)
               (lambda (name)
                 (push name installs)
                 ;; Installing two also installs three as a dependency.
                 (setq installed (append '(two three) installed)))))
      (my/install-packages)
      (my/install-packages)
      (should (= refreshes 1))
      (should (equal installs '(two))))))

(ert-deftest my/packages-failure-explains-recovery-and-can-resume ()
  (let ((my/required-packages '(one two))
        installed
        (offline t))
    (cl-letf (((symbol-function 'package-installed-p)
               (lambda (name) (memq name installed)))
              ((symbol-function 'package-refresh-contents) #'ignore)
              ((symbol-function 'package-install)
               (lambda (name)
                 (when (and offline (eq name 'two)) (error "Network unavailable"))
                 (push name installed))))
      (let ((err (should-error (my/install-packages))))
        (should (string-match-p "Network unavailable" (error-message-string err)))
        (should (string-match-p "M-x my/install-packages" (error-message-string err))))
      (should (equal installed '(one)))
      (setq offline nil)
      (my/install-packages)
      (should (equal installed '(two one))))))

(ert-deftest my/packages-bootstrap-emacs-29-1-seq ()
  (skip-unless (equal emacs-version "29.1"))
  ;; Reproduce the real package.el failure using a local package: seq is
  ;; already loaded, and its replacement requires a newly unpacked file.
  (let* ((fixture (make-temp-file "emacs-seq-fixture-" t))
         (source (expand-file-name "seq-9.0" fixture))
         (my/required-packages '(seq))
         (attempts 0))
    (make-directory source)
    (with-temp-file (expand-file-name "seq.el" source)
      (insert ";;; seq.el --- Test fixture -*- lexical-binding: t; -*-\n"
              "(require 'seq-25)\n(provide 'seq)\n"))
    (with-temp-file (expand-file-name "seq-25.el" source)
      (insert "(provide 'seq-25)\n"))
    (with-temp-file (expand-file-name "seq-pkg.el" source)
      (insert "(define-package \"seq\" \"9.0\" \"Test fixture\" nil)\n"))
    (should-not (featurep 'seq-25))
    (cl-letf (((symbol-function 'package-installed-p) (lambda (_) nil))
              ((symbol-function 'package-refresh-contents) #'ignore)
              ((symbol-function 'package-install)
               (lambda (_)
                 (cl-incf attempts)
                 (package-install-file source))))
      ;; package.el demotes the reload error and completes installation in
      ;; normal startup; ERT's debugger would stop before that recovery.
      (let ((debug-on-error nil)) (my/install-packages)))
    (should (= attempts 1))
    (should (featurep 'seq-25))
    (delete-directory fixture t)))

(let ((test-directory package-user-dir))
  (add-hook 'kill-emacs-hook
            (lambda () (delete-directory test-directory t))))

;;; init-packages-test.el ends here
