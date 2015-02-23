
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
			  "Work.org"
			  ))

;;;; TODO
;; keywords. @, ! are add note, timestamp
(setq org-todo-keywords
      '((sequence
	 "TODO(t)"
	 "STARTED(s!)"
	 "BLOCKED(b@/!)"
	 "WAITING(w@/!)"
	 "|"
	 "DONE(d!)"
	 "CANCELED(c@/!)"
	 )))

;;; breaking down subtasks
;;; http://orgmode.org/manual/Breaking-down-tasks.html

;; provide statistics
(setq org-provide-todo-statistics t)
(setq org-hierarchical-todo-statistics nil)

;; automatically change entry to DONE when all its children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


;; provide full path to my org files
(setq my-org-files
      (mapcar (lambda (f) (concat org-directory f))
	      my-org-files-short))

;; ;;;; startup showing content
;; (setq org-startup-folded "summary")

;;;; block changes to DONE that have incomplete children/dependencies
;; http://orgmode.org/manual/TODO-dependencies.html
(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

;;;; hide leading stars
(setq org-hide-leading-stars t)

;;;; the org agenda
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files my-org-files)
(setq org-agenda-todo-list-sublevels t)

(custom-set-variables
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 )

;;;; capture notes to this file
(setq org-default-notes-file (concat org-directory "refile.org"))

;; let refiling know about my org files
(setq org-refile-targets  '((org-agenda-files :maxlevel . 5)))

;; set Ctrl-c c to call org-capture
(define-key global-map "\C-cc" 'org-capture)

;;;; start the week on Saturdays
(setq org-agenda-start-on-weekday 6)

;;;; setup priorities
;; Scheme:
;;   - A: tasks I MUST do
;;   - B: tasks I SHOULD do
;;   - C: tasks I MAY do
;;   - D: tasks I DELEGATE
;;   - E: tasks I eleminate
(setq org-highest-priority ?A)
(setq org-lowest-priority ?E)
(setq org-default-priority ?B)
(setq org-use-priority-inheritance '("PRIORITY"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'orgmode-setup)
