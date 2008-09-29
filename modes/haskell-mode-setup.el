(provide 'haskell-mode-setup)

(defvar haskell-mode-root "~/emacs/modes/haskell-mode/2.4")
(add-to-list 'load-path haskell-mode-root)
(load (concat haskell-mode-root "/haskell-site-file.el"))

<<<<<<< HEAD:modes/haskell-mode-setup.el
(setq haskell-program-name "/opt/local/bin/ghci")
=======
(setq haskell-program-name (if system-type 'darwin
							 "/opt/local/bin/ghci"
							 "ghci"))
>>>>>>> alpha:modes/haskell-mode-setup.el
