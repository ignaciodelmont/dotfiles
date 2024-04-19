(defun org-mode-visual-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (setq org-ellipsis " ▾"
	org-hide-emphasis-markers t))

(use-package org
  :ensure t
  :hook (org-mode . org-mode-visual-setup)
  :config
  (setq org-todo-keywords '((sequence "TODO(t)" "WIP(w)" "BLOCKED(b)" "ASK(a)" "MR(m)" "|" "DONE(d)"))
	org-todo-keyword-faces '(("WIP" . "yellow")
				 ("BLOCKED" . "orange")
				 ("ASK" . "blue")
				 ("DONE" . "green")
				 ("TODO" . "red")
				 ("MR" . "purple"))
	org-agenda-files '("~/org-roam/Work" "~/org-roam/Personal" "~/org-roam")
	org-agenda-start-with-log-mode t
	org-log-done 'time
	org-log-into-drawer t
	))




(use-package org-bullets
  :ensure t
  :after org
  :hook (org-mode . org-bullets-mode))



;; org roam

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org-roam")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  )

(setq org-directory "~/org-roam")

;; org-ql
(use-package org-ql
  :quelpa (org-ql :fetcher github :repo "alphapapa/org-ql"))



;; https://orgmode.org/worg/org-tutorials/org-custom-agenda-commands.html
(setq org-agenda-custom-commands
      '(
	("kt" "Kognitos ITEMS"
         ((org-ql-block '(and (todo "TODO")
                              (tags "KOG"))
                        ((org-ql-block-header "Kognitos TODOS")))

	  (org-ql-block '(and (todo "WIP")
			      (tags "KOG"))
			((org-ql-block-header "Kognitos WIPs")))

	  (org-ql-block '(and (todo "MR")
			      (tags "KOG"))
			((org-ql-block-header "Kognitos MRs")))

	  
	  (org-ql-block '(and (todo "ASK")
			      (tags "KOG"))
			((org-ql-block-header "Kognitos ASKs")))
	  ;; (agenda) ;; if uncommented it includes the agenda
	  ))
	("p" "Personal"
	 ((org-ql-block '(tags "personal")
			((org-ql-block-header "Personal")))
	  
	  )
	 )
	;; ... other commands here
	))
