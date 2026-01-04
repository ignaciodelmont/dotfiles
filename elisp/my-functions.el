;; Clean up unused packages occasionally
(defun my/cleanup-packages ()
  "Prune unused straight packages."
  (interactive)
  (straight-prune-build)
  (message "Cleaned up unused packages"))
