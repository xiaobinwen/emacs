(setq user-full-name "Holmes")
(setq user-mail-address "xiaobinwen@phoenixos.com")

;;title format
(setq frame-title-format '("%S"(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; 不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)

;;不显示GNU emacs启动界面
(setq inhibit-startup-message t) 

;;光标靠近鼠标指针时, 鼠标自动让开
(mouse-avoidance-mode 'animate)

;; 显示行号
(global-linum-mode t)

;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)

;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;支持emacs和外部程序粘贴
(setq x-select-enable-clipboard t)

;;当前行高亮
(global-hl-line-mode 1)

;打开出时的文件
;(desktop-save-mode 1)

;;显示括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

(setq default-tab-width 4)

;; (setq c-default-style "linux"
;; 	  c-basic-offset 4)
(setq c-basic-offset 4)

;;开启时放大窗口
(setq initial-frame-alist '((top . 0) (left . 0) (width . 200) (height . 70)))

;; 去掉工具栏
(tool-bar-mode 0)
;; (scroll-bar-mode 0)

(setq buffer-read-only nil) 
(setq inhibit-read-only t) 

;;disable the version control
;(setq vc-handled-backends nil)

;;add color-theme
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)
;;(color-theme-Black)

;tabbar
(add-to-list 'load-path "~/.emacs.d/mylisps")
(load-file "~/.emacs.d/mylisps/tabbar.el")
(require 'tabbar)
(tabbar-mode 1)

(setq default-fill-column 200)

(global-set-key [(meta j)] 'tabbar-forward)
(global-set-key [(meta k)] 'tabbar-backward)

(global-set-key [f11] 'my-fullscreen)

;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0))
)

;最大化
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
;启动时最大化
(my-maximized)


;; (add-to-list 'load-path "~/.emacs.d/plugins/Highlight-Indentation-for-Emacs")
;; (load-file "~/.emacs.d/plugins/Highlight-Indentation-for-Emacs/highlight-indentation.el")
;; (set-face-background 'highlight-indentation-face "#e3e3d3")
;; (set-face-background 'highlight-indentation-current-column-face "#c3b3b3")

; close defaultp tabs，and move all files into one group
(setq tabbar-buffer-list-function
     (lambda ()
         (remove-if
           (lambda(buffer)
              (find (aref (buffer-name buffer) 0) " *"))
           (buffer-list))))

(setq tabbar-buffer-groups-function
      (lambda()(list "All")))

;(set-face-attribute 'tabbar-button nil)

;;Set tabbar's backgroud color
(set-face-attribute 'tabbar-default nil
                    :background "gray"
                    :foreground "gray30")
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :background "green"
                    :box '(:line-width 3 :color "DarkGoldenrod") )
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 3 :color "gray"))
 
;; USEFUL: set tabbar's separator gap
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default default default italic underline success warning error])
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (misterioso)))
 '(ecb-layout-always-operate-in-edit-window (quote (split-window-horizontally switch-to-buffer)))
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(ecb-show-ecb-windows-after-hook t)
 '(ecb-source-path (quote (("/" "/"))))
 '(ecb-toggle-layout-sequence (quote ("left3")))
 '(fill-column 120)
 '(global-font-lock-mode t)
 '(org-agenda-files (quote ("~/org/git.org")))
 '(safe-local-variable-values (quote ((eval ignore-errors (require (quote whitespace)) (whitespace-mode 1)) (whitespace-line-column . 79) (whitespace-style face indentation) (eval progn (c-set-offset (quote innamespace) (quote 0)) (c-set-offset (quote inline-open) (quote 0))) (indent-tabs-mode . true) (eval progn (c-set-offset (quote case-label) (quote 0)) (c-set-offset (quote innamespace) (quote 0)) (c-set-offset (quote inline-open) (quote 0))))))
 '(transient-mark-mode t)
 '(truncate-partial-width-windows t))
 
;;doxymacs-1.8.0
(add-to-list 'load-path  "~/.emacs.d/mylisps/doxymacs-1.8.0/lisp/")
(require 'doxymacs)

;;注释高亮，针对C和C++程序  
(defun my-doxymacs-font-lock-hook ()  
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))  
        (doxymacs-font-lock)))

(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(doxymacs-mode)
(add-hook 'c-mode-common-hook 'doxymacs-mode)  
(add-hook 'c++-mode-common-hook 'doxymacs-mode)
(global-set-key [(f6)] 'doxymacs-mode)

;;cscope
;(require 'cc-mode)
(add-to-list 'load-path "~/.emacs.d/mylisps")
(require 'xcscope)
(add-hook 'c-mode-common-hook '(lambda ()(require 'xcscope)))
(add-hook 'c++-mode-common-hook '(lambda ()(require 'xcscope)))

(global-set-key "\C-ci" 'cscope-find-files-including-file) 
(global-set-key "\C-cf" 'cscope-find-this-file) 
(global-set-key "\C-cg" 'cscope-find-egrep-pattern)  
(global-set-key "\C-ct" 'cscope-find-this-text-string) 
(global-set-key "\C-cr" 'cscope-find-this-symbol) 
(global-set-key "\C-cl" 'cscope-find-global-definition)
(global-set-key "\C-cu" 'cscope-pop-mark) 

;; ;;添加对AC的支持
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(add-to-list 'load-path "~/.emacs.d/plugins/popup-el")
(add-to-list 'load-path "~/.emacs.d/plugins/fuzzy-el")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             "~/.emacs.d/auto-complete/dict")
(ac-config-default)
(setq ac-auto-start nil)
(ac-set-trigger-key "<C-return>")

(setq ac-fuzzy-enable t)

;添加yasnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(yas/global-mode 1)
 
;;; ### coding ###
;;; --- 编码设置
(setq default-buffer-file-coding-system 'utf-8-unix)            ;缓存文件编码
(setq default-file-name-coding-system 'utf-8-unix)              ;文件名编码
(setq default-keyboard-coding-system 'utf-8-unix)               ;键盘输入编码
(setq default-process-coding-system '(utf-8-unix . utf-8-unix)) ;进程输出输入编码
(setq default-sendmail-coding-system 'utf-8-unix)               ;发送邮件编码
(setq default-terminal-coding-system 'utf-8-unix)               ;终端编码

;cedet init
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)

;; (semantic-mode 1)
;; (require 'semantic/ia)
;; (require 'semantic/bovine/gcc)
;; (semantic-add-system-include "/usr/include/c++/4.7.2" 'c++-mode)
;; (semantic-add-system-include "/usr/include/" 'c-mode)

;;h, cpp文件跳转函数, 支持即时按键选择 http://www.emacswiki.org/emacs/eassist
;; (add-to-list 'load-path "~/.emacs.d/mylisps")
;; (load-file "~/.emacs.d/mylisps/eassist.el")
;; (require 'eassist)

;; (defun cedet-hook ()
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-c=" 'semantic-decoration-include-visit)
;;   (local-set-key "\C-cj" 'semantic-ia-fast-jump)
;;   (local-set-key "\C-cq" 'semantic-ia-show-doc)
;;   (local-set-key "\C-cs" 'semantic-ia-show-summary)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;   )

;; (add-hook 'c-mode-common-hook 'cedet-hook)
;; (add-hook 'lisp-mode-hook 'cedet-hook)
;; (add-hook 'emacs-lisp-mode-hook 'cedet-hook)

;; (semanticdb-enable-gnu-global-databases 'c-mode t)

(global-ede-mode 1)
(ede-enable-generic-projects)

(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)
 
(add-to-list 'load-path "~/.emacs.d/mylisps/ecb-2.40")
(setq stack-trace-on-error nil)
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)

(require 'ecb)
(require 'ecb-autoloads)

;;;; 各窗口切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;; ;;;; 隐藏和显示ecb 窗口
;; (define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
;; (define-key global-map [(control f2)] 'ecb-show-ecb-windows)

;;;; 使某一ecb 窗口最大化
;; (define-key global-map "\C-c1" 'ecb-maximize-window-directories)
(define-key global-map "\C-c1" 'ecb-maximize-window-history)
(define-key global-map "\C-c2" 'ecb-maximize-window-sources)
(define-key global-map "\C-c3" 'ecb-maximize-window-methods)

;恢复原始窗口布局
(define-key global-map "\C-c0" 'ecb-restore-default-window-sizes) 

(global-set-key [f5] 'ecb-goto-window-history)
(global-set-key [f6] 'ecb-goto-window-methods)
(global-set-key [f7] 'ecb-goto-window-edit1)
(global-set-key [f8] 'grep-find)

;; 调用shell 环境
(setq shell-file-name "/bin/bash")
(global-set-key [f12] 'shell)
(global-set-key [M-f12] 'rename-buffer)

;;reload current buffer
(global-set-key [M-f11] 'revert-buffer)

;;org-mode
(define-key global-map "\C-ca" 'org-agenda)
(setq org-startup-indented t)

(ecb-layout-define "mylayout" left 
  ;; (ecb-set-sources-buffer) 
  (ecb-set-history-buffer) 
  (ecb-split-ver 0.4)
  (ecb-set-methods-buffer) 
  (select-window (next-window))) 

(setq ecb-tree-indent 1)
(setq ecb-windows-width 0.2)
;;(setq ecb-compile-window-height 8)
(setq ecb-layout-name "mylayout") 

;; (custom-set-variables 
;;   ;; custom-set-variables was added by Custom. 
;;   ;; If you edit it by hand, you could mess it up, so be careful. 
;;   ;; Your init file should contain only one such instance. 
;;   ;; If there is more than one, they won't work right. 
;;  '(ecb-options-version "2.40")) 
;; (custom-set-faces 
;;   ;; custom-set-faces was added by Custom. 
;;   ;; If you edit it by hand, you could mess it up, so be careful. 
;;   ;; Your init file should contain only one such instance. 
;;   ;; If there is more than one, they won't work right. 
;;  ) 

;; (defun mycscopse ()
;;   "auto exec <cscopse-indexer -r> and set directory of the cscope"
;;   (interactive)
;;   (shell-command "/usr/bin/cscope-indexer -r /opt/wpos_kernel/kernel_source")
;;   )
;; (global-set-key [f8] 'mycscopse)

;; ;; 执行exit退出
;; ;; (add-hook 'shell-mode-hook 'my-shell-mode-hook-func t)

;; ;; (defun 'my-shell-mode-hook-func (b)
;; ;;  "the one actually kill shell buffer when exit."
;; ;;  (set-process-sentinel (get-buffer-process (current-buffer))
;; ;; 		       #'my-shell-mode-kill-buffer-on-exit))

;; ;; (defun 'my-shell-mode-kill-buffer-on-exit (process state)
;; ;;  (message "%s" state)
;; ;;  (if (or
;; ;;      (string-match "exited abnormally with code.*" state)
;; ;;      (string-match "finished" state))
;; ;;      (kill-bUffer (Current-buffer))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
;; (put 'scroll-left 'disabled nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-set-key [(f9)] 'loop-alpha) ;;

(setq alpha-list '((85 55) (100 100)))

(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
)
