(provide 'slime-setup)

(add-to-list 'load-path "~/emacs/modes/slime/")
(setq inferior-lisp-program "~/emacs/sw/clojure/target/clojure.jar")
(require 'slime)
(slime-setup)