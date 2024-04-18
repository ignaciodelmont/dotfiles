;; Package management
(require 'package)

(package-initialize)

(setq package-archives
      '(("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")
	("elpa" . "https://elpa.gnu.org/packages/")))

(print package-archives)



(unless package-archive-contents
  (package-refresh-contents))

; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

; quelpa
(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

; quelpa use-package
(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)


;; UI
(load "~/elisp/ui")

;; Default Behavior
(setq make-backup-files nil) ; don't store backup files anywhere
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t))) ; don't clutter up the filesystem with autosave files


(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config (exec-path-from-shell-initialize))

(setq global-auto-revert-mode t) ; reload files when they change on disk
(setq truncate-partial-width-windows nil) ; truncate even if the window is split
(setq-default truncate-lines t) ; truncate lines instead of wrapping them
(setq word-wrap nil) ; don't wrap words


;; Keybindings
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'super)

;; Syntax
(use-package flycheck)

;; lsp
(setq lsp-diagnostic-package :none) ; disables lsp as default checker for flycheck (alongside other stuff)
(use-package lsp-ui)

;; dap-mode
(use-package dap-mode
  :ensure t)



;; Which Key
(use-package which-key
  :init
  (setq which-key-idle-delay 0.3)
  :config
  (which-key-mode))


;; Company
(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

;; With use-package:
(use-package company-box
  :hook (company-mode . company-box-mode))

;; Copilot

; ref:  https://github.com/zerolfx/copilot.el
; in order to enable it run M-x copilot-login

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("dist" "*.el"))
  :hook (prog-mode . copilot-mode)
  :config (with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  )

(use-package tree-sitter-langs
  :ensure t)

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))


;; Magit
(use-package magit)


;; Helm
(use-package helm
  :ensure t
  :config (helm-mode 1))

;; Ripgrep
(use-package ripgrep
  :ensure t)

;; Projectile
(use-package projectile
  :ensure t
  :bind (:map projectile-mode-map
	      ("s-p" . projectile-command-map))
  :config
  (projectile-mode +1))


(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (setq completion-styles '(flex)))


(use-package projectile-ripgrep
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p s s") 'projectile-ripgrep))

;; Rainbow delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Buffers
(load "~/elisp/buffer-configs")

;; Languages
(load "~/elisp/python-configs")
(load "~/elisp/clojure-configs")
(load "~/elisp/ts-js-configs")
;; (load "~/elisp/go-configs")

;; Org
(load "~/elisp/org-configs")
(put 'narrow-to-region 'disabled nil)


;; Files Tree View
(use-package neotree
  :ensure t)

(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


;; Custom file
(setq custom-file "~/elisp/emacs-custom.el")
(load custom-file)
