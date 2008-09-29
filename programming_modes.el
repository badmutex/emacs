(provide 'programming_modes)

;;;;|======================================================================|;;;;
;;;; Haskell programming
(setq haskell-program-name "ghci")
(add-to-list 'load-path "~/emacs/programming_modes/haskell-mode")
(load "~/emacs/programming_modes/haskell-mode/haskell-site-file.el")
(add-to-list 'exec-path "~/emacs/programming_modes/exec-mods")

;;;; Flyspell: on-the-fly spellchecker
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Dellay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(setq flyspell-sort-corrections nil)


;; (require 'flymake)

;; (defun flymake-Haskell-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-with-folder-structure nil nil
;;    (file-name-nondirectory buffer-file-name)
;;    'flymake-get-Haskell-cmdline))

;; (defun flymake-get-Haskell-cmdline (source base-dir)
;;   (list "flycheck_haskell.pl"
;; 		(list source base-dir)))

;; (push '(".+\\.hs$" flymake-Haskell-init flymake-simple-java-cleanup)
;; 	  flymake-allowed-file-name-masks)
;; (push '(".+\\.lhs$" flymake-Haskell-init flymake-simple-java-cleanup)
;; 	  flymake-allowed-file-name-masks)
;; (push
;;  '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.+\\)"
;;    1 2 3 4) flymake-err-line-patterns)

;; ;; enable flymake by default
;; (add-hook
;;  'haskell-mode-hook
;;  '(lambda ()
;; 	(if (not (null buffer-file-name)) (flymake-mode))))


;;;;|======================================================================|;;;;
;;;; perl programming
(add-hook 'perl-mode-hook 'flymake-mode)



;;;;|======================================================================|;;;;
;;;; latex stuff
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)


;;;;|======================================================================|;;;;
;;;; shell scripting mode



;;;;|======================================================================|;;;;
;;;; Lisp with SLIME
(setq inferior-lisp-program "/usr/bin/sbcl")
;;(add-to-list 'load-path "path to slime directory")
(require 'slime)
(slime-setup)
