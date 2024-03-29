;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Font
(if (string-equal (system-name) "icewing")
    (setq doom-font (font-spec :family "Hack" :size 22)
          doom-variable-pitch-font (font-spec :family "DejaVu Sans")
          doom-unicode-font (font-spec :family "DejaVu Sans Mono")
          doom-big-font (font-spec :family "Hack" :size 28)))

(if (string-equal (system-name) "greyarea")
    (setq doom-font (font-spec :family "Hack" :size 36)
          doom-variable-pitch-font (font-spec :family "DejaVu Sans")
          doom-unicode-font (font-spec :family "DejaVu Sans Mono")
          doom-big-font (font-spec :family "Hack" :size 40)))

(if (string-equal (system-name) "celedyr")
    (setq doom-font (font-spec :family "Hack" :size 20)
          doom-variable-pitch-font (font-spec :family "DejaVu Sans")
          doom-unicode-font (font-spec :family "DejaVu Sans Mono")
          doom-big-font (font-spec :family "Hack" :size 26)))

(if (string-equal (system-name) "rabbit")
    (setq doom-font (font-spec :family "Hack" :size 20)
          doom-variable-pitch-font (font-spec :family "DejaVu Sans")
          doom-unicode-font (font-spec :family "DejaVu Sans Mono")
          doom-big-font (font-spec :family "Hack" :size 26)))

;; Key Bindings
(define-key evil-normal-state-map "Q" 'fill-paragraph)

(defun liu233w/ex-kill-buffer-and-close ()
  (interactive)
  (unless (char-equal (elt (buffer-name) 0) ?*)
    (kill-this-buffer))
  )

(defun liu233w/ex-save-kill-buffer-and-close ()
  (interactive)
  (save-buffer)
  (kill-this-buffer)
  )

(evil-ex-define-cmd "q[uit]" 'liu233w/ex-kill-buffer-and-close)
(evil-ex-define-cmd "wq" 'liu233w/ex-save-kill-buffer-and-close)

(with-eval-after-load 'rjsx-mode
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil))

;(add-hook 'mu4e-compose-mode-hook 'my-compose-mode-hook)
(global-eldoc-mode -1)

(add-hook 'buffer-list-update-hook
          (lambda () 
            (global-eldoc-mode -1)))

(add-hook 'after-change-major-mode-hook
          (lambda ()
            (setq counsel-find-file-ignore-regexp (rx ".#"))
            (smartparens-global-mode -1)
            (global-evil-surround-mode 1)
            (auto-insert-mode 0)
            ))

(defun my-markdown-mode-hook ()
  (electric-indent-local-mode -1)
  (markdown-gfm-use-electric-backquote nil))

(add-hook 'markdown-mode-hook
          'my-markdown-mode-hook)

; Prevent emacs from grabbing mouse.
;(setq server-raise-frame nil)

(setq company-idle-delay nil)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-enable-auto-pairing nil)
  (setq web-mode-enable-auto-quoting nil)
  (setq web-mode-enable-auto-expanding nil)
  (setq web-mode-enable-auto-closing nil)

  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  )
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.eex$" . web-mode))

(defun my-js2-mode-hook ()
  (setq js2-basic-offset 2)
  (setq! comment-line-break-function nil))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(defun my-json-mode-hook ()
  (make-local-variable 'js-indent-level)
  (setq js-indent-level 2))
(add-hook 'json-mode-hook 'my-json-mode-hook)

(add-hook
 'rust-mode-hook
 (lambda ()
   (racer-mode)
   (setq-local eldoc-documentation-function #'ignore)))

(add-hook
  'nxml-mode-hook
  (lambda ()
    (setq nxml-slash-auto-complete-flag nil)))

(defun my-c-mode-common-hook ()
  (setq c-set-style "stroustrup")
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq c-basic-offset 4)
  (c-set-offset 'access-label '/)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(setq! comment-line-break-function nil)

;; Maybe fix some CPU issues
;(setq history-length 10)
;(put 'minibuffer-history 'history-length 50)
;(put 'evil-ex-history 'history-length 50)
;(put 'kill-ring 'history-length 25)

;; Try to prevent undo-tree stack overflows.
(setq undo-limit 40000
      undo-outer-limit 8000000
      undo-strong-limit 100000)
(after! undo-tree
        (setq undo-tree-auto-save-history nil))
