(provide 'haskell-mode-setup)

(defvar haskell-mode-root (concat emacs-root "/modes/haskell-mode.git"))
(add-to-list 'load-path haskell-mode-root)
(load (concat haskell-mode-root "/haskell-site-file.el"))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)




;; (setq haskell-program-name 
;; 	  (if (eq system-type 'darwin)
;; 		  "/opt/local/bin/ghci"
;; 		"ghci"))
