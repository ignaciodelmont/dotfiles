;; Themes
(use-package all-the-icons)
(use-package doom-themes)
(use-package doom-modeline
  :init (doom-modeline-mode 1))
(use-package solarized-theme)

;; UI
(scroll-bar-mode -1)  ; Disable visible scrollbar
(tool-bar-mode -1)    ; Disable the toolbar
(tooltip-mode -1)     ; Disable tooltips
(set-fringe-mode 2)   ; Some breathing room
(global-display-line-numbers-mode t) ; Line numbers
(add-to-list 'default-frame-alist '(undecorated . t))
(global-hl-line-mode 1)

