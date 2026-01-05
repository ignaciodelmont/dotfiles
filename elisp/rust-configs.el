(use-package rustic
  :config
  (setq rustic-format-on-save nil)
  (setq rustic-lsp-client 'lsp-mode)
  :hook ((rustic-mode . lsp-deferred)
         (rustic-mode . (lambda()
                          (flycheck-select-checker 'rustic-clippy))))
  :custom
  (rustic-cargo-use-last-stored-arguments t))
