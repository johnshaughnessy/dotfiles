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
(setq doom-font (font-spec :family "monospace" :size 28))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-molokai)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-peacock)
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

;;(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

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
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'my/copilot-tab-or-indent)
              ("TAB" . 'my/copilot-tab-or-indent)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  :config
  (progn
    (setq copilot-max-char -1)
    (setq copilot-indent-offset-warning-disable t)
    )
  )

(after! emmet-mode
  (map! :map emmet-mode-keymap
        "<tab>" nil))

(defun my/copilot-tab-or-indent ()
  "Use `copilot-accept-completion` if available, else `indent-for-tab-command`."
  (interactive)
  (unless (and (fboundp 'copilot-accept-completion)
               (copilot-accept-completion))
    (indent-for-tab-command)))

(global-set-key (kbd "TAB") 'my/copilot-tab-or-indent)


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

(add-load-path! "/home/john/src/osai-pal/pal-emacs-plugin")
(use-package pal :demand t)
(after! ivy (ivy-add-actions
             'ivy-find-file
             '(("s" 'pal-ivy-view-summary-action "View Summary"))))
(defun my/pal-status-wrapper ()
  (interactive)
  (if (featurep 'pal)
      (pal-status)
    (message "pal is not loaded")))
(map! :leader
      :desc "Run pal-status"
      "l l" #'my/pal-status-wrapper)

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


(add-load-path! "/home/john/src/acorn/pal-emacs/")
(use-package acorn-pal-emacs
  :demand t
  :config
  (setq acorn-pal--base-url "http://localhost:4444")
  )

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
