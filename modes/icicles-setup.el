(provide 'icicles-setup)

(require 'icicles-install)
(setq icicle-download-dir (concat emacs-root "/modes/icicles"))
(add-to-list 'load-path icicle-download-dir)

(require 'icicles)
