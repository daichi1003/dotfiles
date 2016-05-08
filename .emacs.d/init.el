
;; load-pathへの追加
(add-to-list 'load-path "~/.emacs.d/elisp/elpa")

;; Setting for japanese IM
(setq default-input-method "MacOSX")

;; Beep sound
(setq ring-bell-function 'ignore)

;; Highlight present line
(require 'hl-line)
(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
;;(cancel-timer global-hl-line-timer)


;; Calculate separeted window size 
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

;; C-t for window separation and moving
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)

;; Make no backup files
(setq make-backup-files nil)
;; Delete autosave files at end
(setq delete-auto-save-files t)

;; for widow system
(if window-system
    (progn
      (set-frame-parameter nil 'alpha 95)))

;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elisp/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)    

;; Save the component of buffer automatically
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 1) ; save at the ideling second
(auto-save-buffers-enhanced t)

(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-initialize)

					; (load-theme 'solarized-dark t)
(color-theme-solarized-dark)
;https://blog.sleeplessbeastie.eu/2014/06/09/how-to-use-solarized-theme-in-emacs/

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ
;http://keisanbutsuriya.hateblo.jp/entry/2015/02/08/175005

;;;
;;; org-mode
;;;
;; org-modeの初期化
(require 'org-install)
;; キーバインドの設定
;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)
;; (define-key global-map "\C-cr" 'org-remember)
;; ;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; ;; org-modeでの強調表示を可能にする
;; (add-hook 'org-mode-hook 'turn-on-font-lock)
;; ;; 見出しの余分な*を消す
;; (setq org-hide-leading-stars t)
;; ;; org-default-notes-fileのディレクトリ
;; (setq org-directory "~/org/")
;; ;; org-default-notes-fileのファイル名
;; (setq org-default-notes-file "notes.org")
;; ;http://d.hatena.ne.jp/tamura70/20100203/org

;; anything.el
(require 'anything)
(require 'anything-config)
(define-key global-map (kbd "C-l") 'anything)
(setq anything-sources (list anything-c-source-buffers
			     anything-c-source-bookmarks
			     anything-c-source-recentf
			     anything-c-source-file-name-history
			     anything-c-source-locate
			     anything-c-source-emacs-commands))

;; flymake
(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cc$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

(require 'helm-config)
(helm-mode 1)
;; 自動補完を無効
(custom-set-variables '(helm-ff-auto-update-initial-value nil))
;; ミニバッファでC-hをバックスペースに割り当て
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
;; TABで補完
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
;; キーバインド
;;(define-key global-map (kbd "C-x b")   'helm-buffers-list)
(define-key global-map (kbd "C-x b") 'helm-for-files)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)
(define-key global-map (kbd "M-x")     'helm-M-x)
(define-key global-map (kbd "M-y")     'helm-show-kill-ring)
