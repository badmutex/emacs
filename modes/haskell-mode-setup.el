(provide 'haskell-mode-setup)

(defvar haskell-mode-root "~/emacs/modes/haskell-mode/2.4")
(add-to-list 'load-path haskell-mode-root)
(load (concat haskell-mode-root "/haskell-site-file.el"))

(setq haskell-program-name (if (eq system-type 'darwin)
							   "/opt/local/bin/ghci"
							 "ghci"))
