(provide 'settings)

(require 'org-mode-setup)

;;;; startup options
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;;;; remove toolbars
(menu-bar-mode -1)


;;;; editor options
(require 'ido)
(ido-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq default-tab-width 4)
(setq flyspell-sort-corrections nil)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(set-face-foreground 'minibuffer-prompt "green")

(mouse-wheel-mode t)
(delete-selection-mode t)
(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)

;;;; use versioned backups, node clobber symlinks, and don't litter fs tree
(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/emacs/saves"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-version 2
 version-control 5)

;;;; setup tramp for remote editing
;; (require 'tramp)
;; (setq tramp-default-method "rsync")

;;;; allow changing cases of regions
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
