
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Haskell mode
(defvar haskell-root (concat emacs-root "/modes/haskell-mode.git/"))
(add-to-list 'load-path haskell-root)
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list haskell-root)


(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'cua-selection-mode)

;; Interactive Block Indentation
(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-c ,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-c .") 'haskell-move-nested-right)))



(provide 'modes-setup)
