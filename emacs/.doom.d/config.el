;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Shaughnessy"
      user-mail-address "john@johnshaughnessy.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 28))
(setq doom-font (font-spec :family "PragmataPro" :size 18 :weight 'regular))
(setq doom-variable-pitch-font (font-spec :family "PragmataPro" :size 18))



;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;; https://github.com/doomemacs/themes/tree/screenshots
;; (setq doom-theme 'doom-molokai) ;; Best theme?
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-peacock)
(setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'doom-oceanic-next)
;; (setq doom-theme 'doom-vibrant)
;; (setq doom-theme 'doom-dracula)
;; (load-theme doom-theme)

;; If you intend to use org, it is recommended you change this!
;; (setq org-directory "~/org/")
;;(setq org-directory (file-truename "~/src/notes/"))
(setq org-directory (file-truename "~/src/acorn/records/roam"))
;; (setq org-directory (file-truename "~/org/"))
;; ;; (setq org-directory (file-name-directory buffer-file-name))
;; (setq org-roam-directory (file-truename (concat org-directory "roam/")))
;; (setq org-roam-templates-directory (file-truename (concat org-roam-directory "templates/")))
;; (setq org-roam-nodes-directory (file-truename (concat org-roam-directory "nodes/")))
;; (setq org-agenda-files (list org-directory org-roam-directory org-roam-nodes-directory))

;; (defun file-to-string (file)
;;   "File to string function"
;;   (with-temp-buffer
;;     (insert-file-contents file)
;;     (buffer-string)))

;; (defun template-todo ()
;;   "hello"
;; (let* ((keys "t")
;;        (description "TODO")
;;        (type 'plain)
;;        (template "* ${title} %^G ")
;;        (target-type 'file+head)
;;        (target-location (concat org-roam-nodes-directory "%<%Y%m%d%H%M%S>-${slug}.org"))
;;        (target-template (file-to-string (concat org-roam-templates-directory "todo.org")))
;;        (target (list target-type
;;                      target-location
;;                      target-template))
;;        (unnarrowed t)
;;        (todo (list keys
;;                    description
;;                    type
;;                    template
;;                    :target target
;;                    :unnarrowed unnarrowed))
;;        )
;;   todo
;;   ))

;; (setq org-roam-capture-templates
;;       (list (template-todo)))


;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "Toggle truncate lines"                     "t" #'toggle-truncate-lines))
(setq truncate-lines nil)

(after! config
  (add-to-list '+lookup-provider-url-alist '("Crates.io" "https://crates.io/search?q=%s") 'append)
  (add-to-list '+lookup-provider-url-alist '("Docs.rs" "https://docs.rs/releases/search?query=%s") 'append)
  )

;; https://magit.vc/manual/ghub/Storing-a-Token.html#Storing-a-Token
(setq auth-sources '("~/.authinfo"))

;; Disable smartparens globally
(smartparens-global-mode -1)

;; Ensure smartparens is disabled in specific modes
(remove-hook 'prog-mode-hook #'smartparens-mode)
(remove-hook 'typescript-tsx-mode-hook #'smartparens-mode)

;; Remove specific smartparens hooks
(remove-hook 'post-self-insert-hook #'sp--post-self-insert-hook-handler)
(remove-hook 'pre-command-hook #'sp--save-pre-command-state)
(remove-hook 'post-command-hook #'sp--post-command-hook-handler)

(setq post-self-insert-hook nil)

(after! smartparens
  (progn
    (smartparens-global-mode -1)
    (smartparens-mode -1)
    (turn-off-smartparens-mode)
    (turn-off-smartparens-strict-mode)
    ;; Ensure smartparens is disabled in specific modes
    (remove-hook 'prog-mode-hook #'smartparens-mode)
    (remove-hook 'typescript-tsx-mode-hook #'smartparens-mode)

    ;; Remove specific smartparens hooks
    (remove-hook 'post-self-insert-hook #'sp--post-self-insert-hook-handler)
    (remove-hook 'pre-command-hook #'sp--save-pre-command-state)
    (remove-hook 'post-command-hook #'sp--post-command-hook-handler)

    (setq post-self-insert-hook nil)
    ))

;; Add a hook that runs whenever we open ANY buffer to turn-off-smartparens-mode:
(add-hook 'find-file-hook 'turn-off-smartparens-mode)

;; Also, call it when we open a new buffer
(add-hook 'after-change-major-mode-hook 'turn-off-smartparens-mode)


;; Avoid performance issues in files with very long lines.
(global-so-long-mode 1)

;; Use local version of prettier
;; (defun my/prettier-js-mode ()
;;   (let* ((root (locate-dominating-file
;;                 (or (buffer-file-name) default-directory)
;;                 "node_modules"))
;;          (prettier (and root
;;                         (expand-file-name "node_modules/.bin/prettier"
;;                                           root))))
;;     (when (and prettier (file-executable-p prettier))
;;       (setq-local prettier-js-command prettier)))
;;   (prettier-js-mode))

;; (use-package! prettier-js-mode
;;   :hook ((js2-mode tide-mode typescript-mode typescript-tsx-mode) . my/prettier-js-mode))

;; (setq lsp-typescript-tsdk "/src/memory-cache-browser-client/client2/node_modules/typescript/lib")


;; (not js2-mode tide-mode typescript-mode emacs-lisp-mode sql-mode tex-mode latex-mode org-msg-edit-mode)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell.

This is particularly useful under Mac OSX, where GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; Save buffers when Dom control-S's
(map! "C-s" #'save-buffer)

(load! "+lsp")

(map! :map git-commit-mode-map
      :desc "Co-Author Dom" :n "C-c C-a" (cmd! (git-commit-co-authored "Dominick D'Aniello" "netpro2k@gmail.com"))
      :n "C-c C-S-a" 'git-commit-co-authored)

;; Enable exporting to github flavored markdown
(eval-after-load "org"
  '(require 'ox-gfm nil t))

;; Disable smart parens globally
(smartparens-global-mode -1)

;; Set copilot-max-char to -1 AFTER the package is loaded
;; We also need to set copilot-indent-offset-warning-disable to t
;; We can do that inside of use-package! by using the :config keyword
;; Bind it to alt-tab too
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("s-<tab>" . 'my/copilot-tab-or-indent))
  :config
  (progn
    (setq copilot-max-char -1)
    (setq copilot-indent-offset-warning-disable t)
    )
  )

(setq copilot-max-char -1)


(after! emmet-mode
  (map! :map emmet-mode-keymap
        "<tab>" nil
        "S-<tab>" nil
        ))

(defun my/copilot-tab-or-indent ()
  "Use `copilot-accept-completion` if available, else `indent-for-tab-command`."
  (interactive)
  (unless (and (fboundp 'copilot-accept-completion)
               (copilot-accept-completion))
    (indent-for-tab-command)))


;; Bind s-<tab> to 'my/copilot-tab-or-indent
(global-set-key (kbd "s-<tab>") 'my/copilot-tab-or-indent)


;; Bind <backtab> to `format-all-buffer' after loading `format-all'
(after! format-all
  (message "Setting <backtab> to `format-all-buffer'")
  (global-set-key (kbd "<backtab>") 'format-all-buffer))

(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
        sql-mode         ; sqlformat is currently broken
        tex-mode         ; latexindent is broken
        latex-mode
        web-mode
        c++-mode
        ))       ; exclude web-mode from auto formatting


(setq password-cache-expiry 3600)


;; --- OSAI PAL ---
;; https://github.com/johnshaughnessy/osai-pal

;; (add-load-path! "/home/john/src/osai-pal/pal-emacs-plugin")
;; (use-package pal :demand t)
;; (after! ivy (ivy-add-actions
;;              'ivy-find-file
;;              '(("s" 'pal-ivy-view-summary-action "View Summary"))))
;; (defun my/pal-status-wrapper ()
;;   (interactive)
;;   (if (featurep 'pal)
;;       (pal-status)
;;     (message "pal is not loaded")))
;; (map! :leader
;;       :desc "Run pal-status"
;;       "l l" #'my/pal-status-wrapper)

;; Editing from the command line
(defun my-edit-and-execute-command-hook ()
  "Check if the current buffer is a temporary file and switch to insert mode."
  (when (and (stringp buffer-file-name)
             ;; You might need to adjust the condition below according to how your temporary buffers are named or located
             (string-match "/tmp/zsh.*\\.zsh$" buffer-file-name))
    (evil-insert 0)
    (local-set-key (kbd "C-c C-c") 'server-edit)
    )
  )
;;
;; Org roam

(add-hook 'find-file-hook 'my-edit-and-execute-command-hook)

(use-package org-roam
  :ensure t
  :custom
                                        ;(org-roam-directory (file-truename "~/src/notes/roam/"))
  (org-roam-directory (file-truename "~/src/acorn/records/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))


;; (add-load-path! "/home/john/src/acorn/pal-emacs/")
;; (use-package acorn-pal-emacs
;;   :demand t
;;   :config
;;   (setq acorn-pal--base-url "http://localhost:4444")
;;   )

;; emacs-mozc
(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-mozc")
(require 'mozc)
(setq default-input-method "japanese-mozc")
(prefer-coding-system 'utf-8)

(defun set-mozc-mode-enabled (enabled)
  "Enable or disable mozc-mode"
  (if enabled
      (mozc-mode 1)
    (mozc-mode -1)))

(map! "M-e" (cmd! (set-mozc-mode-enabled nil)))
(map! "M-w" (cmd! (set-mozc-mode-enabled t)))


;; Remove the default keybinding for org-return
;; evil-org-mode-map <normal-state> <return>
;; evil-org-mode-map <normal-state> RET

(after! org-mode
  (map! :map org-mode-map
        :n "RET" nil
        :n "<return>" nil
        :i "RET" nil
        :i "<return>" nil
        ))

(after! evil-org
  (map! :map evil-org-mode-map
        :n "RET" nil
        :n "<return>" nil
        :i "RET" nil
        :i "<return>" nil
        ))

;; Colors https://tailwindcss.com/docs/customizing-colors
;; Slate 50 #f8fafc 100 #f1f5f9 200 #e2e8f0 300 #cbd5e1 400 #94a3b8 500 #64748b 600 #475569 700 #334155 800 #1e293b 900 #0f172a 950 #020617 Gray 50 #f9fafb 100 #f3f4f6 200 #e5e7eb 300 #d1d5db 400 #9ca3af 500 #6b7280 600 #4b5563 700 #374151 800 #1f2937 900 #111827 950 #030712 Zinc 50 #fafafa 100 #f4f4f5 200 #e4e4e7 300 #d4d4d8 400 #a1a1aa 500 #71717a 600 #52525b 700 #3f3f46 800 #27272a 900 #18181b 950 #09090b Neutral 50 #fafafa 100 #f5f5f5 200 #e5e5e5 300 #d4d4d4 400 #a3a3a3 500 #737373 600 #525252 700 #404040 800 #262626 900 #171717 950 #0a0a0a Stone 50 #fafaf9 100 #f5f5f4 200 #e7e5e4 300 #d6d3d1 400 #a8a29e 500 #78716c 600 #57534e 700 #44403c 800 #292524 900 #1c1917 950 #0c0a09 Red 50 #fef2f2 100 #fee2e2 200 #fecaca 300 #fca5a5 400 #f87171 500 #ef4444 600 #dc2626 700 #b91c1c 800 #991b1b 900 #7f1d1d 950 #450a0a Orange 50 #fff7ed 100 #ffedd5 200 #fed7aa 300 #fdba74 400 #fb923c 500 #f97316 600 #ea580c 700 #c2410c 800 #9a3412 900 #7c2d12 950 #431407 Amber 50 #fffbeb 100 #fef3c7 200 #fde68a 300 #fcd34d 400 #fbbf24 500 #f59e0b 600 #d97706 700 #b45309 800 #92400e 900 #78350f 950 #451a03 Yellow 50 #fefce8 100 #fef9c3 200 #fef08a 300 #fde047 400 #facc15 500 #eab308 600 #ca8a04 700 #a16207 800 #854d0e 900 #713f12 950 #422006 Lime 50 #f7fee7 100 #ecfccb 200 #d9f99d 300 #bef264 400 #a3e635 500 #84cc16 600 #65a30d 700 #4d7c0f 800 #3f6212 900 #365314 950 #1a2e05 Green 50 #f0fdf4 100 #dcfce7 200 #bbf7d0 300 #86efac 400 #4ade80 500 #22c55e 600 #16a34a 700 #15803d 800 #166534 900 #14532d 950 #052e16 Emerald 50 #ecfdf5 100 #d1fae5 200 #a7f3d0 300 #6ee7b7 400 #34d399 500 #10b981 600 #059669 700 #047857 800 #065f46 900 #064e3b 950 #022c22 Teal 50 #f0fdfa 100 #ccfbf1 200 #99f6e4 300 #5eead4 400 #2dd4bf 500 #14b8a6 600 #0d9488 700 #0f766e 800 #115e59 900 #134e4a 950 #042f2e Cyan 50 #ecfeff 100 #cffafe 200 #a5f3fc 300 #67e8f9 400 #22d3ee 500 #06b6d4 600 #0891b2 700 #0e7490 800 #155e75 900 #164e63 950 #083344 Sky 50 #f0f9ff 100 #e0f2fe 200 #bae6fd 300 #7dd3fc 400 #38bdf8 500 #0ea5e9 600 #0284c7 700 #0369a1 800 #075985 900 #0c4a6e 950 #082f49 Blue 50 #eff6ff 100 #dbeafe 200 #bfdbfe 300 #93c5fd 400 #60a5fa 500 #3b82f6 600 #2563eb 700 #1d4ed8 800 #1e40af 900 #1e3a8a 950 #172554 Indigo 50 #eef2ff 100 #e0e7ff 200 #c7d2fe 300 #a5b4fc 400 #818cf8 500 #6366f1 600 #4f46e5 700 #4338ca 800 #3730a3 900 #312e81 950 #1e1b4b Violet 50 #f5f3ff 100 #ede9fe 200 #ddd6fe 300 #c4b5fd 400 #a78bfa 500 #8b5cf6 600 #7c3aed 700 #6d28d9 800 #5b21b6 900 #4c1d95 950 #2e1065 Purple 50 #faf5ff 100 #f3e8ff 200 #e9d5ff 300 #d8b4fe 400 #c084fc 500 #a855f7 600 #9333ea 700 #7e22ce 800 #6b21a8 900 #581c87 950 #3b0764 Fuchsia 50 #fdf4ff 100 #fae8ff 200 #f5d0fe 300 #f0abfc 400 #e879f9 500 #d946ef 600 #c026d3 700 #a21caf 800 #86198f 900 #701a75 950 #4a044e Pink 50 #fdf2f8 100 #fce7f3 200 #fbcfe8 300 #f9a8d4 400 #f472b6 500 #ec4899 600 #db2777 700 #be185d 800 #9d174d 900 #831843 950 #500724 Rose 50 #fff1f2 100 #ffe4e6 200 #fecdd3 300 #fda4af 400 #fb7185 500 #f43f5e 600 #e11d48 700 #be123c 800 #9f1239 900 #881337 950 #4c0519
;; Stone
(setq stone-50 "#fafaf9")
(setq stone-100 "#f5f5f4")
(setq stone-200 "#e7e5e4")
(setq stone-300 "#d6d3d1")
(setq stone-400 "#a8a29e")
(setq stone-500 "#78716c")
(setq stone-600 "#57534e")
(setq stone-700 "#44403c")
(setq stone-800 "#292524")
(setq stone-900 "#1c1917")
(setq stone-950 "#0c0a09")

;; Slate
(setq slate-50 "#f8fafc")
(setq slate-100 "#f1f5f9")
(setq slate-200 "#e2e8f0")
(setq slate-300 "#cbd5e1")
(setq slate-400 "#94a3b8")
(setq slate-500 "#64748b")
(setq slate-600 "#475569")
(setq slate-700 "#334155")
(setq slate-800 "#1e293b")
(setq slate-900 "#0f172a")
(setq slate-950 "#020617")

;; Tailwindcss doesn't define slate-750, but let's define one that is interpolated between 700 and 800:
(setq slate-750 "#25303f")
;; Also 850
(setq slate-850 "#1a2330")

;; Purple
(setq purple-50 "#faf5ff")
(setq purple-100 "#f3e8ff")
(setq purple-200 "#e9d5ff")
(setq purple-300 "#d8b4fe")
(setq purple-400 "#c084fc")
(setq purple-500 "#a855f7")
(setq purple-600 "#9333ea")
(setq purple-700 "#7e22ce")
(setq purple-800 "#6b21a8")
(setq purple-900 "#581c87")
(setq purple-950 "#3b0764")

;; highlight-indent-guides
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(use-package highlight-indent-guides
  :ensure t
  :config
                                        ;(setq highlight-indent-guides-method 'fill)
  (setq highlight-indent-guides-method 'column)
                                        ; (setq highlight-indent-guides-method 'character)
                                        ;(setq highlight-indent-guides-character ?\|)
  ;; Whether to automatically calculate faces based on the current theme's background color.
  (setq highlight-indent-guides-auto-enabled nil)

  ;; Set faces
  (set-face-background 'highlight-indent-guides-odd-face slate-800)
  (set-face-background 'highlight-indent-guides-even-face slate-700)
  (set-face-foreground 'highlight-indent-guides-character-face slate-800))

;; HL-Line face setting
(use-package hl-line
  :config
  (set-face-background 'hl-line slate-850))

;; Region face setting
(set-face-background 'region slate-800)
