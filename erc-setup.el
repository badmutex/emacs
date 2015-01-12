(require 'erc)

;;;; joining && autojoing

;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect

(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '((".*\\.freenode.net"
	 "#nixos"
	 "#haskell"
	 )))


;;;; tracking

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))


;;;; automatically login
(let ((ercpass "~/.ercpass"))
  (when (file-exists-p ercpass)
    (load "~/.ercpass")
    (require 'erc-services)
    (erc-services-mode 1)
    (setq erc-prompt-for-nickserv-password nil)
    (setq erc-nickserv-passwords
	  '((freenode (("badi" . freenode-badi-pass)))))))



(provide 'erc-setup)
