;;;; Based on:
;;;; http://sachachua.com/blog/2011/01/emacs-24-package-manager

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(provide 'packages-setup)
