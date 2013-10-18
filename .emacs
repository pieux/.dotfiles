(setq default-directory "~/octopress/source/blog/")

; (require 'package)
; (add-to-list 'package-archives 
; '("marmalade" . "http://marmalade-repo.org/packages/") t)
; (package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;; #######################################################################
(set-face-attribute 'default nil :font "Monaco-15")

(evil-mode 1)

; (set-default-font "-microsoft-YaHei_Monaco-normal-normal-normal-*-13-*-*-*-*-0-iso10646-1")
;; 解决org-mode下, table中英混写不对齐
; (set-default-font "Monaco for Powerline 10")
; (if (and (fboundp 'daemonp) (daemonp))
  ; (add-hook 'after-make-frame-functions
            ; (lambda (frame)
              ; (with-selected-frame frame
                                   ; (set-fontset-font "fontset-default" 
                                                     ; 'unicode "YaHei_Monaco 12"))))
  ; (set-fontset-font "fontset-default" 'unicode "YaHei_Monaco 12"))

;; #######################################################################


;; #######################################################################
;; org mode导出HTML设置
;; 在org-mode下的code block语法高亮
(setq org-src-fontify-natively t)
;; 安装了htmlize可以导出html后保持语法高亮

(setq org-export-html-postamble nil) ;; 禁用脚注
;; #######################################################################


;; #######################################################################
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )
;; #######################################################################


;; #######################################################################
;; emacs backup, auto-save, and clean cache.
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

; (setq backup-directory-alist
; '((".*" . ,"~/org/_save")))

; (setq auto-save-file-name-transforms
; '((".*" ,"~/org/_saves" t)))

; (message "Deleting old backup files...")
; (let ((week (* 60 60 24 7))
; (current (float-time (current-time))))
; (dolist (file (directory-files temporary-file-directory t))
; (when (and (backup-file-name-p file)
; (> (- current (float-time (fifth (file-attributes file))))
; week))
; (message "%s" file)
; (delete-file file))))
;; #######################################################################


;; #######################################################################
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
      "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

;; #######################################################################
;; org mode with octopress

(add-to-list 'load-path "~/.emacs.d/man/orglue")
(add-to-list 'load-path "~/.emacs.d/man/emacs-ctable")
(add-to-list 'load-path "~/.emacs.d/man/org-octopress")

(require 'org-octopress)
(setq org-octopress-directory-top       "~/octopress/source")
(setq org-octopress-directory-posts     "~/octopress/source/_posts")
(setq org-octopress-directory-org-top   "~/octopress/source")
(setq org-octopress-directory-org-posts "~/octopress/source/blog")
;; (setq org-octopress-setup-file          "~/.emacs.d/man/org-octopress/setupfile-sample.org")

;; #######################################################################
;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)

(defun org-toggle-iimage-in-org ()
  "display images in your org file"
  (interactive)
  (if (face-underline-p 'org-link)
    (set-face-underline-p 'org-link nil)
    (set-face-underline-p 'org-link t))
  (iimage-mode))
;; #######################################################################
