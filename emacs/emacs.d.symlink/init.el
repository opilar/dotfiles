(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(projectile-global-mode)

(package-initialize)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(desktop-save-mode t)

(load-theme 'solarized-dark t)
