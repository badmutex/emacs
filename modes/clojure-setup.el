(provide 'clojure-setup)

(add-to-list 'load-path (concat emacs-root "/modes/clojure/clojure-mode"))
(require 'clojure-mode)

(setq swank-clojure-jar-path (concat emacs-root "/modes/clojure/clojure.jar"))
(add-to-list 'load-path (concat emacs-root "/modes/clojure/swank-clojure"))
(require 'swank-clojure-autoload)


(setq auto-mode-alist
      (cons '("\\.clj$" . clojure-mode)
	    auto-mode-alist))

(add-hook 'clojure-mode-hook
	  '(lambda ()
	     (define-key clojure-mode-map "\C-c\C-e" 'lisp-eval-last-sexp)))

(setq
 swank-clojure-extra-classpaths
 (list "/home/badi/.clojure"))