;; Do not merge git submodules as part of the parent, treat them as separate modules
(setq project-vc-merge-submodules nil)

;; Terminal
(use-package vterm)

;; Claude code IDE
(use-package claude-code-ide
  :straight (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :custom
  (claude-code-ide-terminal-backend 'vterm)
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools


;; Project customizations
(defcustom project-root-markers
  '("Cargo.toml" "compile_commands.json" "compile_flags.txt"
    "project.clj" ".git" "deps.edn" "shadow-cljs.edn" "pyproject.toml" ".project")
  "Files or directories that indicate the root of a project."
  :type '(repeat string)
  :group 'project)

(defun project-root-p (path)
  "Check if the current PATH has any of the project root markers."
  (catch 'found
    (dolist (marker project-root-markers)
      (when (file-exists-p (concat path marker))
        (throw 'found marker)))))

(defun project-find-root (path)
  "Search up the PATH for `project-root-markers'."
  (let ((path (expand-file-name path)))
    (catch 'found
      (while (not (equal "/" path))
        (if (not (project-root-p path))
            (setq path (file-name-directory (directory-file-name path)))
          (throw 'found (cons 'transient path)))))))

(use-package project
  :config
  (add-to-list 'project-find-functions #'project-find-root))
