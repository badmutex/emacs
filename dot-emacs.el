(provide 'dot-emacs)

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)
(add-to-list 'load-path (concat emacs-root "/modes"))

(require 'haskell-mode-setup)
(require 'keybindings)
(require 'settings)
