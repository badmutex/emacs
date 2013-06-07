(provide 'latex-setup)

(load "auctex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(setq longlines-show-hard-newlines t)
(setq longlines-wrap-follows-window-size t)


(setq auto-mode-alist
	  (cons '("\\.tex" . LaTeX-mode)
			auto-mode-alist))


(if (eq system-type 'windows-nt) (require 'tex-mik))

(if (eq system-type 'darwin)
	(custom-set-variables
	 '(TeX-output-view-style '(("^pdf$" "." "open %o %(outpage)")))))