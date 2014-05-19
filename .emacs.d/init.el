(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit
		      starter-kit-lisp
		      starter-kit-bindings
		      starter-kit-eshell
		      clojure-mode
		      clojure-test-mode
                      color-theme-solarized
                      cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-hook 'clojure-mode-hook 'whitespace-mode)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-popup-stacktraces nil)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

(setq solarized-termcolors 16)
(load-theme 'solarized-dark t)
