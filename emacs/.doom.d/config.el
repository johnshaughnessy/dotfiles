;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-peacock)
;; (setq doom-theme 'doom-oceanic-next)
;; (setq doom-theme 'doom-vibrant)
(setq doom-theme 'doom-molokai)
;; (setq doom-theme 'doom-dracula)
;;(load-theme 'doom-peacock t)

;; If you intend to use org, it is recommended you change this!
;; (setq org-directory "~/org/")
(setq org-directory "~/src/notes/")

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

;; https://magit.vc/manual/ghub/Storing-a-Token.html#Storing-a-Token
(setq auth-sources '("~/.authinfo"))

;; Handle transparency for this frame
(defun set-alpha (alpha) (set-frame-parameter (selected-frame) 'alpha alpha))
(defun transparency-off () (set-alpha 100))
(defun transparency-on () (set-alpha (frame-parameter (selected-frame) 'alpha-when-transparent)))
(defun transparency-very-on () (set-alpha (frame-parameter (selected-frame) 'alpha-when-very-transparent)))
(defun is-very-transparent ()
  (= (frame-parameter (selected-frame) 'alpha)
     (frame-parameter (selected-frame) 'alpha-when-very-transparent)))
(defun is-exactly-transparent ()
  (= (frame-parameter (selected-frame) 'alpha)
     (frame-parameter (selected-frame) 'alpha-when-transparent)))
(defun toggle-transparency ()
  (interactive)
  (if (is-exactly-transparent) (transparency-off) (transparency-on)))
(defun toggle-very-transparent ()
  (interactive)
  (if (is-very-transparent) (transparency-off) (transparency-very-on)))
(defun set-transparency (value)
   "Sets the transparency of the frame window. 0=transparent/100=opaque"
   (interactive "nAlpha value for transparency 0=transparent/100=opaque:")
     (if (not (= 100 value)) (set-frame-parameter (selected-frame) 'alpha-when-transparent value))
     (set-alpha value))
(defun set-very-transparency (value)
   "Sets the transparency of the frame window. 0=transparent/100=opaque"
   (interactive "nAlpha value for very-transparent 0=transparent/100=opaque:")
   (if (not (= 100 value)) (set-frame-parameter (selected-frame) 'alpha-when-very-transparent value))
   (set-alpha value))

(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Toggle transparency"                     "p" #'toggle-transparency))

(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Toggle very transparent"                     "o" #'toggle-very-transparent))

(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Set alpha of transparency"                     "P" #'set-transparency))

(map! :leader
      (:prefix-map ("t" . "toggle")
        :desc "Set alpha of very transparent"                     "O" #'set-very-transparency))


(set-frame-parameter (selected-frame) 'alpha-when-transparent 95)
(set-frame-parameter (selected-frame) 'alpha-when-very-transparent 15)
(set-alpha (frame-parameter (selected-frame) 'alpha-when-transparent))

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
  :hook ((js2-mode tide-mode typescript-mode) . my/prettier-js-mode))

;; (setq org-capture-templates
;;       '(("f" "Feels" entry (file+headline "~/src/notes/feels/feels.org" "Feels")
;;          "* %U %?\n %i \n")
;;         ("4" "Stress Level 4" entry (file+headline "~/src/notes/feels/feels.org" "Stress")
;;          "* %U Stress Level 4%?\n %i \n")
;;         ("5" "Stress Level 5" entry (file+headline "~/src/notes/feels/feels.org" "Stress")
;;          "* %U Stress Level 5" :immediate-finish 1)
;;         ("6" "Stress Level 6" entry (file+headline "~/src/notes/feels/feels.org" "Stress")
;;          "* %U Stress Level 6" :immediate-finish 1)
;;         ("7" "Stress Level 7" entry (file+headline "~/src/notes/feels/feels.org" "Stress")
;;          "* %U Stress Level 7" :immediate-finish 1)
;;         ("8" "Stress Level 8" entry (file+headline "~/src/notes/feels/feels.org" "Stress")
;;          "* %U Stress Level 8" :immediate-finish 1)))

;; (setq org-capture-templates
;;       '(("t" "TODO" entry (file+headline "~/src/notes/todo.org" "In Focus")
;;          "** %? \n %i %U \n")))

(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "~/src/notes/todo.org" "In Focus")
         "** %? \n %i")))
