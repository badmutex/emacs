(provide 'dot-emacs)

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)
(add-to-list 'load-path (concat emacs-root "/modes"))

;;;; package manager
(require 'elpa)

;;;; grab some usefull modes
(require 'haskell-mode-setup)
(require 'auctex-setup)
(require 'latex-setup)
(require 'git-setup)
(require 'elisp-setup)
(provide 'yasnippet-setup)
(provide 'scala-setup)
(provide 'fsharp-setup)

(require 'keybindings)
(require 'settings)

(require 'my-stuff)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((((class color) (min-colors 8)) (:foreground "yellow" :weight bold))))
 '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "red" :weight bold))))
 '(org-todo ((t (:foreground "magenta" :weight bold)))))
