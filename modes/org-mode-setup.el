

(defvar org-root "~/org.git")

(defvar agenda-file-names
  (list "research.org"
		"school.org"
		"personal.org"))

(setq auto-mode-alist (cons '("\\.org" . org-mode) auto-mode-alist))

(setq org-agenda-files
	  (map 'list (lambda (path)
				   (concat org-root "/" path))
		   agenda-file-names))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done t)

(setq org-hide-leading-stars t)



(provide 'org-mode-setup)