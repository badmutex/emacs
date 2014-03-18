
(defvar modes-root (concat emacs-root "/modes/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Haskell mode
(defvar haskell-root (concat modes-root "/haskell-mode.git/"))
(add-to-list 'load-path haskell-root)
(require 'haskell-mode-autoloads)
(add-to-list 'Info-default-directory-list haskell-root)


(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-font-lock)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook (cua-selection-mode nil))
(add-hook 'haskell-mode-hook 'which-function-mode)

;; Interactive Block Indentation
(eval-after-load "haskell-mode"
  '(progn
     (define-key haskell-mode-map (kbd "C-c ,") 'haskell-move-nested-left)
     (define-key haskell-mode-map (kbd "C-c .") 'haskell-move-nested-right)))

;; Enable which-function
(eval-after-load "which-func"
  '(add-to-list 'which-func-modes 'haskell-mode))

;; Compilation mode with support for Cabal projects
(eval-after-load "haskell-mode"
    '(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(eval-after-load "haskell-cabal"
    '(define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))


;; use the newer haskell-interactive-mode instead of the default inferior-haskell-mode
(eval-after-load "haskell-mode"
  '(progn
    (define-key haskell-mode-map (kbd "C-x C-d") nil)
    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
    (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
    (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
    (define-key haskell-mode-map (kbd "C-c M-.") nil)
    (define-key haskell-mode-map (kbd "C-c C-d") nil)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Nix Mode
(defvar nixmode-root (concat modes-root "/nix-mode/"))
(add-to-list 'load-path nixmode-root)
(require 'nix-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Centered Cursor
(when window-system ; else void symbol error when running from terminal
  (defvar centered-cursor-mode-root (concat modes-root "/centered-cursor-mode/"))
  (add-to-list 'load-path centered-cursor-mode-root)
  (require 'centered-cursor-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'modes-setup)
