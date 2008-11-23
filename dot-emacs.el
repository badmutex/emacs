(provide 'dot-emacs)

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)
(add-to-list 'load-path (concat emacs-root "/modes"))

;;;; grab some usefull modes
(require 'haskell-mode-setup)
(require 'latex-setup)
(require 'git-setup)

(require 'keybindings)
(require 'settings)
