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
			 (require 'dap-python)
			 (setq dap-python-debugger 'debugpy)
			 (auto-virtualenv-set-virtualenv)
			 (lsp)
			 (flycheck-mode 1)
			 (flycheck-select-checker 'python-flake8)
			 (dap-mode 1)
			 (dap-ui-mode 1)
			 )))


(use-package python-black
  :hook (python-mode . python-black-on-save-mode-enable-dwim)
  :bind (:map python-mode-map
	      ("s-b" . python-black-buffer)
	      ("s-r" . python-black-region)))
  
(dap-register-debug-template "Kognitos brain"
  (list :type "python"
        :args ("-k" "test_ocr_text_is_in")
	:cwd (expand-file-name "~/Projects/Kognitos/brain/")
	:env '(("KOGNITOS_ENVIRONMENT" . "shared")("AWS_PROFILE" . "kognitos")("AWS_DEFAULT_REGION" . "us-west-2"))
	:debugger "debugpy"
        :request "launch"
	:module "pytest"
        :name "Test"))
