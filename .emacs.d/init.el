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
                      clj-refactor
		      clojure-mode
                      solarized-theme
                      cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

(add-hook 'clojure-mode-hook 'whitespace-mode)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(setq nrepl-hide-special-buffers t)
(setq cider-show-error-buffer 'except-in-repl)
(setq cider-repl-print-length 100)

(require 'clj-refactor)
(add-hook 'clojure-mode-hook (lambda ()
                               (clj-refactor-mode 1)
                               (cljr-add-keybindings-with-prefix "C-c C-m")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'solarized-light)
