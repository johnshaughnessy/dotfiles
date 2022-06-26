(setq src-me       (file-truename "/home/john/src/me/"))
(setq src-me-notes (file-truename "/home/john/src/me/notes/"))

;; TODO: Use author prefix
(setq author-prefix "#+Author: John Shaughnessy\n")

(setq template-note
  '("n" "note" plain
    (file (lambda () (expand-file-name (format-time-string "%Y-%m-%d-%H-%M-%S.org") src-me-notes)))
    "* %?  :note%^G"
    :unnarrowed t
    )
  )

(setq prefix-key-habit
      '("h" "habit"))

(setq foo
  (expand-file-name "org-mode-templates/habit-wake" src-me-notes))

(setq template-habit-wake
  '("hw" "wake" plain
    (file (lambda () (expand-file-name (format-time-string "%Y-%m-%d-%H-%M-%S.org") src-me-notes)))
    (file "~/src/me/org-mode-templates/habit-wake")
    :unnarrowed t
    )
  )

(setq org-agenda-files (list src-me src-me-notes))
(setq org-capture-templates (list template-note prefix-key-habit template-habit-wake))
(setq org-tag-alist '(("note")
                      ("project")
                      ("question")
                      ("diary")
                      ("todo")
                      ("done")
                      ("goal")
                      ("failed")
                      ("weekly")
                      ("mind")
                      ("body")
                      ("soul")
                      ("habit")
                      ("wake")
                      ("inspire")
                      ))

(setq org-agenda-prefix-format
  '((agenda . " %i %?-12t% s")
   (todo . " %i ")
   (tags . " %i    ")
   (search . " %i "))
        )

(setq org-use-tag-inheritance nil)
