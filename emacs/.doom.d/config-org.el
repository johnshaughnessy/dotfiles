(setq src-me       (file-truename "/home/john/src/me/"))
(setq src-me-notes (file-truename "/home/john/src/me/notes/"))

(setq prefix
      "#+Author: John Shaughnessy\n")
(setq template-note
  '("n" "note" plain
    (file (lambda () (expand-file-name (format-time-string "%Y-%m-%d-%H-%M-%S.org") src-me-notes)))
    "* %? %^G"
    :unnarrowed t
    )
  )

(setq org-agenda-files (list src-me src-me-notes))
(setq org-capture-templates (list template-note))
(setq org-tag-alist '(("note")
                      ("project")
                      ("todo")
                      ("done")
                      ("question")))

(setq org-agenda-prefix-format
  '((agenda . " %i %?-12t% s")
   (todo . " %i ")
   (tags . " %i    ")
   (search . " %i "))
        )

(setq org-use-tag-inheritance nil)
