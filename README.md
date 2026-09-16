# Emacs configuration

Requires Emacs 29 or newer. Clone into `~/.emacs.d` and start Emacs.

On first launch, the configuration downloads missing packages from GNU ELPA
and MELPA. An internet connection is required for this step. Later launches
use the installed packages without contacting the archives, unless a package
listed in `lisp/init-packages.el` is missing.

If installation fails, fix the reported problem and restart Emacs, or run
`M-x my/install-packages` and then restart. Successfully installed packages
are retained, so the next attempt installs only what is still missing.

`elpa/` is intentionally ignored by Git: it contains downloaded dependencies,
generated files, and local package-manager state. The required package list
is tracked instead. This bootstraps a working installation; it does not pin
exact package versions or provide an offline installation.

Run the bootstrap regression tests from this directory with:

```sh
emacs --batch -Q -L lisp -l tests/init-packages-test.el -f ert-run-tests-batch-and-exit
```
