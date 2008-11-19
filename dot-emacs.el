(provide 'dot-emacs)

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)
(add-to-list 'load-path (concat emacs-root "/modes"))

;;;; grab the relevent programming modes
(require 'haskell-mode-setup)
(require 'latex-setup)

(require 'keybindings)
(require 'settings)

;;;; version control setup(s)
(require 'git-setup)

;;;; emacs self-customization
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)
