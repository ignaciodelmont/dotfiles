(setq ring-bell-function 'ignore)
(setq make-backup-files nil) ; don't store backup files anywhere
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t))) ; don't clutter up the filesystem with autosave files


(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config (exec-path-from-shell-initialize))

(global-auto-revert-mode 1)               ; reload files when they change on disk
(setq truncate-partial-width-windows nil) ; truncate even if the window is split
(setq-default truncate-lines t)           ; truncate lines instead of wrapping them
(setq word-wrap nil)                      ; don't wrap words


;; which-key configs
(use-package which-key
  :config
  (setq which-key-idle-delay 0.1)
  (which-key-mode))


