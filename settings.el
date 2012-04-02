(provide 'settings)

(require 'org-mode-setup)

;;;; startup options
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;;;; remove toolbars
(menu-bar-mode -1)


;;;; editor options
;;; kills performance on AFS
;; (require 'ido)
;; (ido-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

(setq x-select-enable-clipboard t)
(setq default-tab-width 4)
(setq flyspell-sort-corrections nil)
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(set-face-foreground 'minibuffer-prompt "green")

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



;;; GUD interface
(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face 'secondary-selection)
    ov)
  "Overlay variable for GUD highlighting.")
   
(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
	 (bf (gud-find-file true-file)))
    (save-excursion
      (set-buffer bf)
      (move-overlay ov (line-beginning-position) (line-beginning-position 2)
      ;;(move-overlay ov (line-beginning-position) (line-end-position)
		    (current-buffer)))))
   
(defun gud-kill-buffer ()
  (if (eq major-mode 'gud-mode)
      (delete-overlay gud-overlay)))
   
(add-hook 'kill-buffer-hook 'gud-kill-buffer)
(put 'upcase-region 'disabled nil)


;;;; read in PATH from .bashrc
;; needed on OSX when using Aquamacs, etc...
(if (string-equal "darwin" (symbol-name system-type))
    (setenv "PATH"
	    (shell-command-to-string "source $HOME/.bashrc && printf $PATH")))


;;; for dark background
;(add-to-list 'default-frame-alist '(cursor-color . "red3"))
;(add-to-list 'default-frame-alist '(foreground-color . "gray85"))
;(add-to-list 'default-frame-alist '(background-color . "gray25"))
;(set-cursor-color "red3")
;(set-face-background 'region "gray85")
;(set-face-foreground 'region "gray25")
;(put 'downcase-region 'disabled nil)



