(require-package 'auto-complete)
(require-package 'auto-complete-clang)  ;clang package for c/c++ completion
(require-package 'ac-c-headers)         ;AC source for c headers
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-expand-on-auto-complete nil)
(setq-default ac-auto-start nil)
(setq-default ac-dwim nil) ; To get pop-ups with docs even if a word is uniquely completed
(ac-set-trigger-key "TAB")              ;AFTER input prefix, press TAB key ASAP

;; Use C-n/C-p to select candidates ONLY when completion menu is displayed
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
;;(setq tab-always-indent 'complete)  ;; DO NOT use 't when auto-complete is disabled
(add-to-list 'completion-styles 'initials t)

;; TODO: find solution for php, c++, haskell modes where TAB always does something

;; hook AC into completion-at-point
(defun sanityinc/auto-complete-at-point ()
  (when (and (not (minibufferp))
	     (fboundp 'auto-complete-mode)
	     auto-complete-mode)
    (auto-complete)))

(defun sanityinc/never-indent ()
  (set (make-local-variable 'indent-line-function) (lambda () 'noindent)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions
        (cons 'sanityinc/auto-complete-at-point
              (remove 'sanityinc/auto-complete-at-point completion-at-point-functions))))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)


(set-default 'ac-sources
             '(ac-source-imenu
               ac-source-dictionary
               ac-source-yasnippet
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-words-in-all-buffer))

(dolist (mode '(magit-log-edit-mode
                log-edit-mode org-mode text-mode haml-mode
                git-commit-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode sh-mode smarty-mode clojure-mode
                lisp-mode textile-mode markdown-mode tuareg-mode
                js3-mode css-mode less-css-mode sql-mode
                sql-interactive-mode
                inferior-emacs-lisp-mode c-mode c++-mode))
  (add-to-list 'ac-modes mode))

;; clang stuff
;; @see https://github.com/brianjcj/auto-complete-clang
(defun my-ac-cc-mode-setup ()
  (require 'auto-complete-clang)
  (require 'ac-c-headers)               ;ac sources for c headers completion, see https://github.com/zk-phi/ac-c-headers
  (setq ac-sources (append '(ac-source-clang ac-source-c-headers) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)

;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)


(provide 'init-auto-complete)
