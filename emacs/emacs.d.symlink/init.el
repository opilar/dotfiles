(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(tool-bar-mode -1)
(scroll-bar-mode -1)

(elpy-enable)
(projectile-global-mode)

(package-initialize)
