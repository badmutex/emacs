(provide 'scala-setup)

(add-to-list 'load-path (concat emacs-root "/modes/scala-mode"))
(require 'scala-mode)

(add-hook 'scala-mode-hook
		  '(lambda ()
			 (yas/minor-mode-on)))
(setq auto-mode-alist
      (cons '("\\.scala$" . scala-mode)
	    auto-mode-alist))


(setq yas/my-directory
	  (concat emacs-root 
			  "/modes/scala-mode/contrib/yasnippet/snippets"))
(yas/load-directory yas/my-directory)