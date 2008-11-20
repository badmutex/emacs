(provide 'settings)

;;;; start the server on startup
(server-start)

;;;; remove toolbars
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(mouse-wheel-mode 1)

;;;; editor options
(fset 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq default-tab-width 4)
(setq flyspell-sort-corrections nil)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

(mouse-wheel-mode t)
;(global-hl-line-mode 1)
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
(require 'tramp)
(setq tramp-default-method "rsync")

;;;; adjust the window size on startup
(set-frame-position (selected-frame) 0 0)
(set-frame-width (selected-frame) 80)
(set-frame-height (selected-frame) 120)
