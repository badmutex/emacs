
(when window-system

  (autoload 'jedi:setup "jedi" nil t)

  (require 'auto-complete)
  (require 'autopair)
  (require 'yasnippet)
  ;; (require 'flycheck)
  ;; (global-flycheck-mode t)

  (setq
   ac-auto-start 2
   ac-override-local-map nil
   ac-use-menu-map t
   ac-candidate-limit 50)

  (require 'python-mode)
  (require 'jedi)

  (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
  (add-hook 'python-mode-hook 'auto-complete-mode)
  (add-hook 'python-mode-hook 'autopair-mode)
  (add-hook 'python-mode-hook 'yas-minor-mode)
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'kill-emacs-hook  'jedi:stop-server)
  (setq jedi:setup-keys t)
  (setq jedi:complete-on-dot t)
  (setq py-electric-colon-active t)
)


;; ;; -------------------- extra nice things --------------------
;; ;; use shift to move around windows
;; (windmove-default-keybindings 'shift)
;; (show-paren-mode t)
;;  ; Turn beep off
;; (setq visible-bell nil)

(provide 'ide-python)

;;; ide-python ends here
