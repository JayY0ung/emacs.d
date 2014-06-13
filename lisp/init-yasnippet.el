;;; Yet another snippet extension for Emacs config
(require-package 'yasnippet)
(require 'yasnippet)

;; Set up mySnippets
(setq my-snippets (expand-file-name "~/.emacs.d/snippets"))
(if (and (file-exists-p my-snippets) (not (member my-snippets yas-snippet-dirs)))
    (add-to-list 'yas-snippet-dirs my-snippets))

;; Global enable yasnippet
(yas-global-mode 1)

(provide 'init-yasnippet)
