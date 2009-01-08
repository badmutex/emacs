(provide 'latex-setup)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode) ; 'longlines-mode)
(setq longlines-show-hard-newlines t)
(setq longlines-wrap-follows-window-size t)

(if (eq system-type 'windows-nt) (require 'tex-mik))
