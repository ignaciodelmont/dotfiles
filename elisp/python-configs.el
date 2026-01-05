(use-package lsp-pyright
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)
                         (flycheck-select-checker 'python-pylint))))
