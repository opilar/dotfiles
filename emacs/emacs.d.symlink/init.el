(setq user-full-name "Michael Rybakov")
(setq user-mail-address "opilar@ya.ru")

(setq is-windows (memq system-type '(windows-nt ms-dos)))

(require 'package)
(let* ((proto (if is-windows "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

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
(menu-bar-mode -1)

;; highlighting mark region
(transient-mark-mode t)

;; system clipboard
(setq x-select-enable-clipboard t)

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; tab settings
(setq tab-width 4
      indent-tabs-mode nil)

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)

(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)

;; Highlight corresponding parentheses when cursor is on one
(show-paren-mode t)

(setq column-number-mode t)

; (require 'auto-complete-config)
; (ac-config-default)

;; plugins
(require-package 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(if is-windows
    (setq projectile-indexing-method 'alien))

; (desktop-save-mode t)

(ido-mode)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(require-package 'ido-vertical-mode)

; (require-package 'solarized-theme)

(load-theme 'wombat t)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(require-package 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(require-package 'cmake-mode)

;; force myself not to use arrows
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

(setq confirm-nonexistent-file-or-buffer nil)

(setq revert-without-query '(".*"))

; (require-package 'auto-update)
; (auto-package-update-maybe)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

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
(company-mode)

;; auto-close brackets
(require-package 'autopair)
(autopair-global-mode)

;; syntax checking
;; (require-package 'flycheck)

;; highlight symbol at point
(require-package 'highlight-symbol)

(setq next-line-add-newlines t)

(if is-windows
    (set-face-attribute `default nil
			:family "Source Code Pro" :height 94)
  (set-default-font "Inconsolata 14"))

;; Org Mode
(require-package 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
