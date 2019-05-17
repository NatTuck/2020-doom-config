;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq doom-font (font-spec :family "Hack" :size 22)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans")
      doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-big-font (font-spec :family "Hack" :size 28))

(add-hook 'after-change-major-mode-hook
          (lambda()
            (setq counsel-find-file-ignore-regexp (rx ".#"))
            (smartparens-global-mode -1)
            (auto-insert-mode 0)
            ))

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
