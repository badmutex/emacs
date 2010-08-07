(provide 'dot-emacs)

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)
(add-to-list 'load-path (concat emacs-root "/modes"))

;; ;;;; package manager
;; (require 'elpa)

;;;; grab some usefull modes
(require 'haskell-mode-setup)
(require 'auctex-setup)
(require 'latex-setup)
(require 'git-setup)
(require 'elisp-setup)
(require 'php-setup)

(provide 'yasnippet-setup)
(provide 'scala-setup)
(provide 'fsharp-setup)


(require 'keybindings)
(require 'settings)

(require 'my-stuff)
