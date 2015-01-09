

(defvar emacs-root "~/emacs")
(add-to-list 'load-path emacs-root)

;;;; startup options
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;;;; assume themse are installed vial elpa/marmalade
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-2.1/")
(load-theme 'misterioso t)

;;;; remove menu- and tool-bars if needed
(unless window-system
  (menu-bar-mode -1))
(when window-system
  (tool-bar-mode -1))


;;;; misc. UI settings
; show the current line and column numbers
(line-number-mode t)
(column-number-mode t)
(global-linum-mode t)
; highligh the current light
(global-hl-line-mode t)
(set-face-background hl-line-face "grey10")
(set-face-foreground 'highlight nil)

; highlight matching parens
(show-paren-mode t)

;;;; use versioned backups, don't clobber symlinks, and don't litter fs tree
(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/.emacs.d/saves"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-version 2
 version-control 5)


;;;; allow changing cases of regions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


;;;; setup for org-mode
(require 'orgmode-setup)

;;;; mode hooks
(require 'modes-setup)

;;; centered cursor
;; (when window-system
;;   (global-centered-cursor-mode +1))


;;;; package repos
(require 'packages-setup)

; autopair braces, quotes
(autopair-global-mode)

; yasnippet mode
(yas-global-mode 1)

; flycheck
;(add-hook 'after-init-hook #'global-flycheck-mode)

(ido-mode t)
