;(custom-set-variables
; '(aquamacs-styles-mode nil nil (color-theme))
; '(one-buffer-one-frame-mode nil nil (aquamacs-frame-setup))
; '(tool-bar-mode nil)
; '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

(add-to-list 'load-path "~/emacs")
(require 'programming_modes)
(require 'editor_options)
(require 'tramp_config)

;-------------------------------------------------------------------;
;--------------------   Emacs set preferences ----------------------;
;--------------                                       --------------;

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(remote-shell-program "/usr/bin/ssh")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)

(put 'upcase-region 'disabled nil)
