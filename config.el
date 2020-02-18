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

(add-hook 'after-change-major-mode-hook
          (lambda()
            (setq counsel-find-file-ignore-regexp (rx ".#"))
            (smartparens-global-mode -1)
            (auto-insert-mode 0)
            ))

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
  (setq js2-basic-offset 2))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(add-hook
 'rust-mode-hook
 (lambda ()
   (racer-mode)
   (setq-local eldoc-documentation-function #'ignore)))

;; Mail

;; Maybe fix some CPU issues
(setq history-length 10)
(put 'minibuffer-history 'history-length 50)
(put 'evil-ex-history 'history-length 50)
(put 'kill-ring 'history-length 25)


;; Projectile
;;     Why doesn't this work?
;; (add-hook
;;  'after-init-hook
;;  (lambda ()
;;    (projectile-register-project-type
;;     'mix '("mix.exs")
;;     :compile "mix compile"
;;     :test "mix test"
;;     :run "mix phx.server"
;;     :test-suffix "_test")))
