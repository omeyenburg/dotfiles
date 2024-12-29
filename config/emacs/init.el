(org-babel-load-file
  (expand-file-name
    "config.org"
    user-emacs-directory))

;;; Bootstrap use-package
;(require 'package)
;(setq package-enable-at-startup nil)
;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;(package-initialize)
;
;;; Ensure use-package is installed
;(unless (package-installed-p 'use-package)
;  (package-refresh-contents)
;  (package-install 'use-package))
;(require 'use-package)
;(setq use-package-always-ensure t)
;
;;; Basic initialization
;(setq inhibit-startup-message t       ; Disable startup message
;      ring-bell-function 'ignore      ; Disable bell
;      gc-cons-threshold most-positive-fixnum) ; Optimize garbage collection
;
;(add-hook 'emacs-startup-hook
;          (lambda () (setq gc-cons-threshold 800000)))
;
;;; Lazy load Evil mode and related packages
;(use-package evil
;  :init
;  (setq evil-want-keybinding nil
;        evil-want-integration t)
;  :config
;  (evil-mode 1)
;  (use-package evil-collection
;    :after evil
;    :config (evil-collection-init))
;  (use-package evil-surround
;    :config (global-evil-surround-mode 1)))
;
;;; Org-mode configuration
;(use-package org
;  :config
;  (setq org-startup-folded 'content)) ; Fold all Org content by default
;
;;; Folding configuration
;;; Enable outline minor mode for Emacs Lisp files
;(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
;
;;; Toggle fold with tab
;(global-set-key (kbd "<tab>") 'outline-toggle-children)
;
;;; Display line numbers
;(global-display-line-numbers-mode 1)
