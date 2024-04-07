(use-package poetry
  :ensure t)


(use-package auto-virtualenv
  :ensure t
  :init
  (use-package pyvenv
    :ensure t)
  :config
  (add-hook 'projectile-after-switch-project-hook 'auto-virtualenv-set-virtualenv)  ;; If using projectile
  )


(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()	
			 (require 'auto-virtualenv)
			 (require 'lsp-pyright)
			 (auto-virtualenv-set-virtualenv)
			 (lsp)
			 (flycheck-mode 1)
			 (flycheck-select-checker 'python-flake8))))


(use-package python-black
  :hook (python-mode . python-black-on-save-mode-enable-dwim)
  :bind (:map python-mode-map
	      ("s-b" . python-black-buffer)
	      ("s-r" . python-black-region)))
  
