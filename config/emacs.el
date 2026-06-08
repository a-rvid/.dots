(setq standard-indent 2)
(tool-bar-mode -1)
(menu-bar-mode -1)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(global-display-line-numbers-mode)

;; Themes
;; (when (display-graphic-p)
;;   (invert-face 'default)
;; )
;; (set-variable 'frame-background-mode 'dark)
(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Evil
(require 'evil)
(evil-mode 1)
(setq evil-insert-state-map (make-sparse-keymap))
(evil-ex-define-cmd "w!" 'save-sudo)

;; Save current buffer to the same file but via sudo (prompts for password)
(defun save-sudo ()
  "Save current buffer as root using TRAMP sudo."
  (interactive)
  (let* ((file (or buffer-file-name
                   (user-error "Buffer not visiting a file")))
         (sudo-path (if (string-match-p "^/[^:]+:" file)
                        ;; already a tramp path: replace method with sudo
                        (replace-regexp-in-string
                         "^/\\([^:]+\\):" "/sudo:\\1:" file)
                      ;; local path -> sudo:: absolute path
                      (concat "/sudo::" file))))
    (when (y-or-n-p (format "Save %s as root? " sudo-path))
      (write-file sudo-path))))

;; (define-key evil-normal-state-map (kbd "gcc") 'comment-line)
(require 'evil-commentary)
(evil-commentary-mode)
(define-key evil-insert-state-map (kbd "<escape>") 'evil-normal-state)
;; (define-key evil-insert-state-map ("C-x") 'evil-normal-state)

;; ;; Jabber.el
;; (setq jabber-account-list
;;     `(("etrademark@low-effort.work"
;; 	(:password . ,(read-passwd "Enter XMPP password: ")))))

;; Browser
;; (require 'webkit) 
;; (global-set-key (kbd "s-b") 'webkit) ;; Bind to whatever global key binding you want if you want
;; (require 'webkit-ace) ;; If you want link hinting
;; (require 'webkit-dark) ;; If you want to use the simple dark mode

;; Eshell
(add-to-list 'eshell-modules-list 'eshell-tramp)
(setq eshell-prefer-lisp-functions t)
(setq eshell-prefer-lisp-variables t)
(setq password-cache t)
(setq password-cache-expiry 12)
