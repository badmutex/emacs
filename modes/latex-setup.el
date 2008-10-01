(provide 'latex-setup)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'TeX-latex-mode 'flyspell-mode)
(add-hook 'latex-mode 'flyspell-mode)