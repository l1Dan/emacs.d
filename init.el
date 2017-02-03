(require 'package) ;;  请求必须的包管理器
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize) ;; 初始化包管理器

;; custom
(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file 'noerror)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar lidan/packages
  '(
    sr-speedbar
    auto-complete
    exec-path-from-shell
    haskell-mode
    magit
    better-defaults
    elpy
    py-autopep8
    ein
    zenburn-theme
    ))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      lidan/packages)

;; Require
(require 'sr-speedbar)
(require 'haskell-mode)
(require 'magit)
(require 'py-autopep8)
(require 'auto-complete-config)
(require 'haskell-unicode-input-method)

(setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/.cabal/bin"))
(setq exec-path (append exec-path '((concat (getenv "HOME") "/.cabal/bin"))))

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-interactive-arg "-i")

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; (autoload 'ghc-init "ghc" nil t)
;; (autoload 'ghc-debug "ghc" nil t)
;; (autoload 'ghc-mod-init "ghc-mod" nil t)

;; (add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)
;; (add-hook 'haskell-mode-hook 'turn-on-haskell-unicode-input-method)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

(custom-set-variables
 '(haskell-stylish-on-save t))

(add-hook 'haskell-mode-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 (append '((company-capf company-dabbrev-code))
                         company-backends))))


;; 自定义配置
(recentf-mode t) ;; scratch 提示语
(auto-revert-mode t) ;; 自动更新对呀buffer中的内容
(display-time-mode t)
(column-number-mode t)
(transient-mark-mode t)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p) ;; y/n
(elpy-enable)
(ac-config-default)
(exec-path-from-shell-initialize)
(speedbar-add-supported-extension ".hs")

(global-hl-line-mode t)
(global-linum-mode t)

;; 字体
(when (eq system-type "gnu/linux")
  (set-default-font "Source Code Pro-15"))
(when (eq system-type "darwin")
  (set-default-font "Monaco-15"))

(setq-default
 initial-scratch-message (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))

;; 开启最近打开文件
(setq-default
 recentf-max-saved-items 100
 recentf-max-menu-items 20)

(setq visible-bell nil)
(setq inhibit-startup-message t) ;; 关闭启动界面
(setq auto-save-default nil) ;; 去掉自动保存
(setq make-backup-files nil) ;; 去掉自动备份文件

(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 25)
(setq dframe-update-speed t)

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-key 'meta
      mac-option-key 'alt
      mac-command-modifier 'meta
      mac-option-modifier 'alt)

(setq default-frame-alist ;; 设置启动界面大小
      '( (left . 200) (top . 80) (height . 34) (width . 120) ))

(setq neo-theme
      (if (display-graphic-p) 'icons 'arrow))

(when window-system
  (tool-bar-mode -1) ;; 关闭工具条
  (scroll-bar-mode -1) ;; 关闭滑动条
  (menu-bar-mode t)
  ;; (load-theme 'solarized-dark t)
  ;; (load-theme 'material t)
  )

(load-theme 'zenburn t)

(when (eq window-system 'nil)
  (menu-bar-mode -1))

(defun open-init-file() ;; 添加打开配置文件的快捷方式
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-x C-j") 'sr-speedbar-toggle)
(global-set-key (kbd "<f1>") 'open-init-file)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(define-key haskell-mode-map (kbd "<f8>") 'haskell-navigate-imports)

(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(define-key ac-completing-map (kbd "M-n") nil)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "M-p") nil)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(put 'upcase-region 'disabled nil)
