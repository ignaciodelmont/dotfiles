(use-package go-mode
  :ensure t
  :hook (
	 (go-mode . (lambda()
		      (lsp-deferred)
		      (flycheck-mode 1)
		      ))
	 (before-save . lsp-format-buffer)
	 ))


(use-package flycheck-golangci-lint
  :ensure t
  :hook ((go-mode . flycheck-golangci-lint-setup)))

(use-package templ-ts-mode
  :ensure t
  :mode "\\.templ\\'")
