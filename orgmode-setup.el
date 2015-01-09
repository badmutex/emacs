
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; usefull resources
;; :examples: Sacha Chua's emacs config: http://pages.sachachua.com/.emacs.d/Sacha.html
;; :doc: capture templates: http://orgmode.org/manual/Capture-templates.html
;; :examples: in-depth organization examples: http://doc.norang.ca/org-mode.html
;; :doc: access rss feeds: http://orgmode.org/manual/RSS-Feeds.html#RSS-Feeds
;; :doc: capture for org: http://orgmode.org/manual/Capture.html#Capture
;; :doc: refiling, capture, archive: http://orgmode.org/manual/Capture-_002d-Refile-_002d-Archive.html
;; :doc: tracking state changes: http://orgmode.org/manual/Tracking-TODO-state-changes.html
;; :ext: get timeline of all files in org-agenda-files

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; location of my .org files
(setq org-directory "~/org.git/")

;;;; my org files
(setq my-org-files-short (list
			  "Home.org"
			  "Jobsearch.org"
			  "Projects.org"
			  "Research.org"
			  ))

;;;; keywords. @, ! are add note, timestamp
(setq org-todo-keywords
      '((sequence
	 "TODO(t)"
	 "STARTED(s!)"
	 "BLOCKED(b@/!)"
	 "WAITING(w@/!)"
	 "DONE(d!)"
	 "CANCELED(c@/!)"
	 )))

;; provide full path to my org files
(setq my-org-files
      (mapcar (lambda (f) (concat org-directory f))
	      my-org-files-short))

;;;; startup showing content
(setq org-startup-folded "content")

;;;; hide leading stars
(setq org-hide-leading-stars t)

;;;; the org agenda
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files my-org-files)

(custom-set-variables
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 )


;; get timeline from all files
(define-key global-map (kbd "C-c t")
  (lambda  (&optional arg)
    (interactive "P")
    (with-temp-buffer
      (dolist (org-agenda-file org-agenda-files)
	(insert-file-contents org-agenda-file nil)
	(end-of-buffer)
	(newline))
      (write-file "/tmp/timeline.org")
      (org-agenda arg "L"))))

;;;; capture notes to this file
(setq org-default-notes-file (concat org-directory "refile.org"))

;; let refiling know about my org files
(setq org-refile-targets  '((org-agenda-files :maxlevel . 5)))

;; set Ctrl-c c to call org-capture
(define-key global-map "\C-cc" 'org-capture)

;;;; start the week on Saturdays
(setq org-agenda-start-on-weekday 6)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'orgmode-setup)
