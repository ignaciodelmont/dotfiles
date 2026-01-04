(use-package rustic
  :config
  (setq rustic-format-on-save nil)
  (setq rustic-lsp-client 'eglot)
  :hook (rustic-mode . (lambda()
                    (flycheck-select-checker 'rustic-clippy)))
  :custom
  (rustic-cargo-use-last-stored-arguments t))
