(provide 'yasnippet-setup)

(add-to-list 'load-path (concat emacs-root "/modes/yasnippet"))
(require 'yasnippet)

(yas/initialize)
(yas/load-directory (concat emacs-root "/modes/yasnippet/snippets"))
