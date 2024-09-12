;; Themes

(use-package all-the-icons
  :if (display-graphic-p))
;; M-x all-the-icons-install-fonts

(use-package doom-themes)
(use-package doom-modeline
  :init (doom-modeline-mode 1))
;; M-x nerd-icons-install-fonts

;; UI
(scroll-bar-mode -1)  ; Disable visible scrollbar
(tool-bar-mode -1)    ; Disable the toolbar
(tooltip-mode -1)     ; Disable tooltips
(set-fringe-mode 2)   ; Some breathing room
(global-display-line-numbers-mode t) ; Line numbers
(add-to-list 'default-frame-alist '(undecorated . t)) ; No title bar
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ; Start in maximized view
(global-hl-line-mode 1)

;; Font (M-x describe-font to get the full list of fonts)
(defun font-exists-p (font) (if (null (x-list-fonts font)) nil t))
(when (window-system)
  (cond
   ((font-exists-p "Courier New") (set-frame-font "Courier New:size=16" nil t))
   ((font-exists-p "M PLUS 1 Code") (set-frame-font "M PLUS 1 Code:pixelsize=12:weight=normal:slant=normal:width=normal:spacing=100:scalable=true:size=16" nil t)))
  )



