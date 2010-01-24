
(defvar auctex-root (concat emacs-root "/modes/auctex/site-lisp"))
(add-to-list 'load-path auctex-root)
(load (concat auctex-root "/auctex.el"))

(provide 'auctex-setup)