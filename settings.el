(provide 'settings)

;;;; editor options
(fset 'yes-or-no-p 'y-or-n-p)
(setq x-select-enable-clipboard t)
(setq default-tab-width 4)
(mouse-wheel-mode t)
(global-hl-line-mode 1)
(line-number-mode t)
(delete-selection-mode t)


;;;; use versioned backups, node clobber symlinks, and don't litter fs tree
(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/saves"))
 delete-old-versions t
 kept-new-versions 6
 kept-old-version 2
 version-control 5)


;;;; setup tramp for remote editing
(require 'tramp)
(setq tramp-default-method "rsync")
