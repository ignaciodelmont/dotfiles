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

;; Performance
(use-package gcmh
  :ensure t
  :config
  (gcmh-mode 1))


(use-package ultra-scroll-mac
  :quelpa (ultra-scroll-mac :fetcher github
		   :repo "jdtsmith/ultra-scroll-mac"
		   :branch "main")
  
  :if (eq window-system 'mac)
  :init
  (setq scroll-conservatively 101 ; important!
        scroll-margin 0) 
  :config
  (ultra-scroll-mac-mode 1))


;; UI
(load "~/elisp/ui")

;; Default Behavior
(setq ring-bell-function 'ignore)
(setq make-backup-files nil) ; don't store backup files anywhere
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t))) ; don't clutter up the filesystem with autosave files


(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config (exec-path-from-shell-initialize))

(global-auto-revert-mode 1) ; reload files when they change on disk
(setq truncate-partial-width-windows nil) ; truncate even if the window is split
(setq-default truncate-lines t) ; truncate lines instead of wrapping them
(setq word-wrap nil) ; don't wrap words

;; Multiple cursor
(use-package multiple-cursors
  :ensure t)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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

(use-package company-box
  :hook (company-mode . company-box-mode))


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


;; Windows
(load "~/elisp/window-configs")

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


;; When using native comp, don't spam with warnings
;; (setq native-comp-async-report-warnings-errors nil)

;; Install manually after emacs is already set up. Installation can be quirky

;; Copilot

; ref:  https://github.com/zerolfx/copilot.el
; in order to enable it run M-x copilot-login

(use-package copilot
  :quelpa (copilot :fetcher github
                   :repo "zerolfx/copilot.el"
                   :branch "main"
                   :files ("*.el"))
  :hook (prog-mode . copilot-mode)
  :config (with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))


