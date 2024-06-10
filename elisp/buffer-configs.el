(defun kill-all-buffers()
  "Kill all buffers."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))


(global-set-key (kbd "C-c k a") 'kill-all-buffers)
(global-set-key (kbd "C-c k o") 'kill-other-buffers)
(global-set-key (kbd "C-c k c") 'kill-current-buffer)
