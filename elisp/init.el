;; Package management

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package via straight
(straight-use-package 'use-package)

;; Make straight.el the default for use-package
(setq straight-use-package-by-default t)

;; Performance
(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))

;; Behaviour
(load "~/elisp/behaviour")

;; UI
(load "~/elisp/ui")

;; My Functions
(load "~/elisp/my-functions")

;; Keybindings
(load "~/elisp/keybindings")

;; Buffer
(load "~/elisp/buffer")

;; IDE configs and packages
(load "~/elisp/ide")

;; Custom file
(setq custom-file "~/elisp/emacs-custom.el")
(load custom-file)


(load "~/elisp/rust-configs")
(load "~/elisp/python-configs.el")
