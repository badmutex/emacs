(provide 'auctex-setup)

(defvar auctex-root "~/emacs/modes/auctex/11.85")
(load (concat auctex-root
			  "/tex-site.el"))
(add-to-lsit 'load-path auctex-root)

