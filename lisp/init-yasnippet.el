;;; Yet another snippet extension for Emacs config
(require-package 'yasnippet)
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs/mySnippets"))         ; Personal snippets
(yas-global-mode 1)

(provide 'init-yasnippet)
