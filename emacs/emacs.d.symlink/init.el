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
