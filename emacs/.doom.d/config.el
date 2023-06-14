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
(setq doom-font (font-spec :family "monospace" :size 32))

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
(setq org-directory (file-truename "~/src/notes/"))
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

;; Configure org-mode stuff
(after! org (load! "./config-org"))

(map! :leader
      (:prefix-map ("t" . "toggle")
       :desc "Toggle truncate lines"                     "t" #'toggle-truncate-lines))
(setq truncate-lines nil)

(after! :config
  (add-to-list '+lookup-provider-url-alist '("Crates.io" "https://crates.io/search?q=%s") 'append)
  (add-to-list '+lookup-provider-url-alist '("Docs.rs" "https://docs.rs/releases/search?query=%s") 'append)
)

;; https://magit.vc/manual/ghub/Storing-a-Token.html#Storing-a-Token
(setq auth-sources '("~/.authinfo"))

;;(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Avoid performance issues in files with very long lines.
(global-so-long-mode 1)

;; Use local version of prettier
(defun my/prettier-js-mode ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (prettier (and root
                        (expand-file-name "node_modules/.bin/prettier"
                                          root))))
    (when (and prettier (file-executable-p prettier))
      (setq-local prettier-js-command prettier)))
  (prettier-js-mode))

(use-package! prettier-js-mode
  :hook ((js2-mode tide-mode typescript-mode typescript-tsx-mode) . my/prettier-js-mode))


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
