;; Easysession configuration

(use-package easysession
  :ensure t
  :custom
  (easysession-save-interval 120) ; Auto-save every 2 minutes
  :config
  (setq frame-title-format '("Emacs - " (:eval (or easysession--current-session-name "no session"))))
  ;; Force title bar refresh on session events
  (add-hook 'easysession-after-load-hook (lambda () (force-mode-line-update t)))
  (add-hook 'easysession-after-save-hook (lambda () (force-mode-line-update t)))
  (add-hook 'easysession-new-session-hook (lambda () (force-mode-line-update t)))
  :init
  (add-hook 'emacs-startup-hook
            #'(lambda ()
                (let* ((env-session-name (getenv "EMACS_SESSION_NAME"))
                       (session-name (if (string-empty-p env-session-name)
                                         "main"
                                       env-session-name)))
                  (let ((easysession-frameset-restore-geometry t))
                    (easysession-switch-to session-name))))
            102)
  (add-hook 'emacs-startup-hook #'easysession-save-mode 103))
