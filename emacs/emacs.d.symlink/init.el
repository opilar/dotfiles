(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(package-initialize)

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
	(if (boundp 'package-selected-packages)
	    ;; Record this as a package the user installed explicitly
	    (package-install package nil)
	  (package-install package))
      (progn
	(package-refresh-contents)
	(require-package package min-version t)))))

(tool-bar-mode -1)
(scroll-bar-mode -1)

(require-package 'projectile)

(desktop-save-mode t)

(ido-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

(require-package 'zenburn-theme)
(load-theme 'zenburn t)

(define-key global-map (kbd "RET") 'newline-and-indent)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(require-package 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(require-package 'cmake-mode)

(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

;; Ask "y" or "n" instead of "yes" or "no". Yes, laziness is great.
(fset 'yes-or-no-p 'y-or-n-p)

(setq confirm-nonexistent-file-or-buffer nil)

(setq revert-without-query '(".*"))

(require-package 'auto-package-update)
(auto-package-update-maybe)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

;; Highlight tabulations
(setq-default highlight-tabs t)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

;; Save backup files in a dedicated directory
(setq backup-directory-alist '(("." . "~/.saves")))

;; complete anything
(require-package 'company)

;; auto-close brackets
(require-package 'autopair)
(autopair-global-mode)

;; syntax checking
(require-package 'flycheck)

;; highlight symbol at point
(require-package 'highlight-symbol)

(require-package 'ido-vertical-mode)
