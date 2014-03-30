
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CMake
(defvar cmake-mode-root (concat modes-root "/cmake-mode/"))
(add-to-list 'load-path cmake-mode-root)
(require 'cmake-mode)
(require 'andersl-cmake-font-lock)
(add-hook 'cmake-mode-hook 'andersl-cmake-font-lock-activate)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; YAML
(add-to-list 'load-path (concat modes-root "/yaml-mode.git/"))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; magit
(add-to-list 'load-path (concat modes-root "/magit.git/"))
(require 'magit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; popup
(add-to-list 'load-path (concat modes-root "/popup.git/"))
(require 'popup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; auto-complete
(add-to-list 'load-path (concat modes-root "/auto-complete.git/"))
(require 'auto-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; auto-pair
(add-to-list 'load-path (concat modes-root "/autopair.git/"))
(require 'autopair)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; yasnippet
(add-to-list 'load-path (concat modes-root "/yasnippet.git/"))
(require 'yasnippet)
; use popup mode to yasnippet prompts
; based on http://iany.me/2012/03/use-popup-isearch-for-yasnippet-prompt/
(define-key popup-menu-keymap (kbd "M-n") 'popup-next)
(define-key popup-menu-keymap (kbd "TAB") 'popup-next)
(define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
(define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
(define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

(defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
  (when (featurep 'popup)
    (popup-menu*
     (mapcar
      (lambda (choice)
        (popup-make-item
         (or (and display-fn (funcall display-fn choice))
             choice)
         :value choice))
      choices)
     :prompt prompt
     ;; start isearch mode immediately
     :isearch t
     )))

(setq yas-prompt-functions '(yas-popup-isearch-prompt yas-no-prompt))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; s (string manipulation library)
(add-to-list 'load-path (concat modes-root "/s.git/"))
(require 's)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; dash
(add-to-list 'load-path (concat modes-root "/dash.git/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; f (file manipulation library)
(add-to-list 'load-path (concat modes-root "/f.git/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; flycheck
(add-to-list 'load-path (concat modes-root "/flycheck.git/"))
(require 'flycheck)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; deferred
(add-to-list 'load-path (concat modes-root "/deferred.git/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ctable
(add-to-list 'load-path (concat modes-root "/ctable.git/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; epc
(add-to-list 'load-path (concat modes-root "/epc.git/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; python-environment
(add-to-list 'load-path (concat modes-root "/python-environment.git//"))
(require 'python-environment)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; jedi
(add-to-list 'load-path (concat modes-root "/jedi.git/"))
(require 'jedi)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; python-mode
(add-to-list 'load-path (concat modes-root "/python-mode.el-6.1.3/"))
(require 'python-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(provide 'modes-setup)
