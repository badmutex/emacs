(provide 'latex-setup)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)

(if (eq system-type 'windows-nt) (require 'tex-mik))
