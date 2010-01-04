(provide 'dot-emacs)

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)
(add-to-list 'load-path (concat emacs-root "/modes"))

;;;; grab some usefull modes
(require 'elpa)

(require 'haskell-mode-setup)
(require 'latex-setup)
(require 'git-setup)
(require 'clojure-setup)
(require 'slime-setup)
(require 'elisp-setup)
(provide 'yasnippet-setup)
(provide 'scala-setup)
(provide 'fsharp-setup)

(require 'icicles-setup)
(require 'keybindings)
(require 'settings)

(require 'my-stuff)
