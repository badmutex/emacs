(provide 'clojure-setup)

(add-to-list 'load-path "~/emacs/modes/clojure/clojure-mode")
(require 'clojure-mode)

(add-to-list 'load-path "~emacs/modes/slime")
(require 'slime)
(slime-setup)

(setq swank-clojure-jar-path "~/emacs/modes/clojure/clojure.jar")
(add-to-list 'load-path "~/emacs/modes/clojure/swank-clojure")
(require 'swank-clojure-autoload)


(setq auto-mode-alist
      (cons '("\\.clj$" . clojure-mode)
	    auto-mode-alist))

(add-hook 'clojure-mode-hook
	  '(lambda ()
	     (define-key clojure-mode-map "\C-c\C-e" 'lisp-eval-last-sexp)))